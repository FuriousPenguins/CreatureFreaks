local pinchZoom = {}
local isDevice = (system.getInfo("environment") == "device")
pinchZoom.simulateMultitouch = true

------------------------------------------------------------------------------------
-- STANDARD MATH FUNCTIONS
------------------------------------------------------------------------------------
-- returns the distance between points a and b
local function lengthOf( a, b )
    local width, height = b.x-a.x, b.y-a.y
    return (width*width + height*height)^0.5
end

-- returns the degrees between (0,0) and pt
-- note: 0 degrees is 'east'
local function angleOfPoint( pt )
	local x, y = pt.x, pt.y
	local radian = math.atan2(y,x)
	local angle = radian*180/math.pi
	if angle < 0 then angle = 360 + angle end
	return angle
end

-- returns the degrees between two points
-- note: 0 degrees is 'east'
local function angleBetweenPoints( a, b )
	local x, y = b.x - a.x, b.y - a.y
	return angleOfPoint( { x=x, y=y } )
end

-- returns the smallest angle between the two angles
-- ie: the difference between the two angles via the shortest distance
local function smallestAngleDiff( target, source )
	local a = target - source
	
	if (a > 180) then
		a = a - 360
	elseif (a < -180) then
		a = a + 360
	end
	
	return a
end

-- rotates a point around the (0,0) point by degrees
-- returns new point object
local function rotatePoint( point, degrees )
	local x, y = point.x, point.y
	
	local theta = math.rad( degrees )
	
	local pt = {
		x = x * math.cos(theta) - y * math.sin(theta),
		y = x * math.sin(theta) + y * math.cos(theta)
	}

	return pt
end

-- rotates point around the centre by degrees
-- rounds the returned coordinates using math.round() if round == true
-- returns new coordinates object
local function rotateAboutPoint( point, centre, degrees, round )
	local pt = { x=point.x - centre.x, y=point.y - centre.y }
	pt = rotatePoint( pt, degrees )
	pt.x, pt.y = pt.x + centre.x, pt.y + centre.y
	if (round) then
		pt.x = math.round(pt.x)
		pt.y = math.round(pt.y)
	end
	return pt
end



-- calculates the average centre of a list of points
local function calcAvgCentre( points )
	local x, y = 0, 0
	
	for i=1, #points do
		local pt = points[i]
		local newX, newY = pt.parent:contentToLocal(pt.x, pt.y)
		x = x + newX
		y = y + newY
	end
	
	return { x = x / #points, y = y / #points }
end

-- calculate each tracking dot's distance and angle from the midpoint
local function updateTracking( centre, points )
	for i=1, #points do
		local point = points[i]
		
		point.prevAngle = point.angle
		point.prevDistance = point.distance
		
		point.angle = angleBetweenPoints( centre, point )
		point.distance = lengthOf( centre, point )
	end
end

-- calculates rotation amount based on the average change in tracking point rotation
local function calcAverageRotation( points )
	local total = 0
	
	for i=1, #points do
		local point = points[i]
		total = total + smallestAngleDiff( point.angle, point.prevAngle )
	end
	
	return total / #points
end

-- calculates scaling amount based on the average change in tracking point distances
local function calcAverageScaling( points )
	local total = 0
	
	for i=1, #points do
		local point = points[i]
		total = total + point.distance / point.prevDistance
	end
	
	return total / #points
end


------------------------------------------------------------------------------------
-- FUNCTION TO SPAWN TRACKING DOT
------------------------------------------------------------------------------------
local function newTrackDot(e)
	-- create a user interface object
	local circle = display.newCircle( e.x, e.y, 50 )
	
	-- make it less imposing
	circle.alpha = .5
	if isDevice or pinchZoom.simulateMultitouch==false then circle.isVisible = false end
	
	-- keep reference to the rectangle
	local rect = e.target
	
	-- standard multi-touch event listener
	function circle:touch(e)
		-- get the object which received the touch event
		local target = circle
		
		-- store the parent object in the event
		e.parent = rect
		
		-- handle each phase of the touch event life cycle...
		if (e.phase == "began") then
			-- tell corona that following touches come to this display object
			display.getCurrentStage():setFocus(target, e.id)
			-- remember that this object has the focus
			target.hasFocus = true
			-- indicate the event was handled
			return true
		elseif (target.hasFocus) then
			-- this object is handling touches
			if (e.phase == "moved") then
				-- move the display object with the touch (or whatever)
				target.x, target.y = e.x, e.y
			else -- "ended" and "cancelled" phases
				-- stop being responsible for touches
				display.getCurrentStage():setFocus(target, nil)
				-- remember this object no longer has the focus
				target.hasFocus = false
			end
			
			-- send the event parameter to the rect object
			rect:touch(e)
			
			-- indicate that we handled the touch and not to propagate it
			return true
		end
		
		-- if the target is not responsible for this touch event return false
		return false
	end
	
	-- listen for touches starting on the touch layer
	circle:addEventListener("touch")
	
	-- listen for a tap when running in the simulator
	function circle:tap(e)
		if (e.numTaps == 2) then
			-- set the parent
			e.parent = rect
			
			-- call touch to remove the tracking dot
			rect:touch(e)
		end
		return true
	end
	
	-- only attach tap listener in the simulator
	if (not isDevice) and pinchZoom.simulateMultitouch then
		circle:addEventListener("tap")
	end
	
	-- pass the began phase to the tracking dot
	circle:touch(e)
	
	-- return the object for use
	return circle
end


------------------------------------------------------------------------------------
-- ADD PINCH ZOOM TO OBJECT
------------------------------------------------------------------------------------
function pinchZoom.add(object, params)
	
	-- set default params if not defined
	if params == nil then params = {} end
	if params.rotate == nil then params.rotate = true end
	if params.scale == nil then params.scale = true end
	if params.drag == nil then params.drag = true end
	if params.singleTouch == nil then params.singleTouch = false end
	
	-- create table to hold tracking dots
	object.dots = {}

	-- advanced multi-touch event listener
	local function touch(self, e)
		-- get the object which received the touch event
		local target = e.target
	
		-- get reference to self object
		local object = self
	
		-- handle began phase of the touch event life cycle...
		if (e.phase == "began") then
			-- enable multitouch & add screen-wide area to catch additional touches
			system.activate("multitouch")

			if #object.dots == 0 and params.singleTouch == true then
				local function catchAllTouch(event)
					event.target = target
					object:touch(event)
					return true
				end
				
				object.catchAll = display.newRect(centerX, centerY, screenWidth, screenHeight)
				object.catchAll.isVisible = false
				object.catchAll.isHitTestable = true
				object.catchAll:addEventListener("touch", catchAllTouch)
			end
		
			-- create a tracking dot
			local dot = newTrackDot(e)
		
			-- add the new dot to the list
			object.dots[ #object.dots+1 ] = dot
		
			-- pre-store the average centre position of all touch points
			object.prevCentre = calcAvgCentre( object.dots )
		
			-- pre-store the tracking dot scale and rotation values
			updateTracking( object.prevCentre, object.dots )
		
			-- we handled the began phase
			return true
		elseif (e.parent == object) then
			if (e.phase == "moved") then
				-- declare working variables
				local centre, scale, rotate = {}, 1, 0
			
				-- calculate the average centre position of all touch points
				centre = calcAvgCentre( object.dots )
			
				-- refresh tracking dot scale and rotation values
				updateTracking( object.prevCentre, object.dots )
			
				-- if there is more than one tracking dot, calculate the rotation and scaling
				if (#object.dots > 1) then
					-- calculate the average rotation of the tracking dots
					rotate = calcAverageRotation( object.dots )
				
					-- calculate the average scaling of the tracking dots
					scale = calcAverageScaling( object.dots )
					local newScale = math.abs(scale*object.xScale)
					if (params.maxScale and newScale > params.maxScale) or (params.minScale and newScale < params.minScale) then
						scale = 1
					end
					
					-- apply rotation to object
					if params.rotate == true then
						object.rotation = object.rotation + rotate
					end
				
					-- apply scaling to object
					if params.scale == true then
						object.xScale, object.yScale = object.xScale * scale, object.yScale * scale
					end
				end
				
				if params.drag == true then
					local pt = {}
			
					-- translation relative to centre point move
					pt.x = object.x + (centre.x - object.prevCentre.x)
					pt.y = object.y + (centre.y - object.prevCentre.y)
			
					-- scale around the average centre of the pinch
					-- (centre of the tracking dots, not the object centre)
					--pt.x = centre.x + ((pt.x - centre.x) * scale)
					--pt.y = centre.y + ((pt.y - centre.y) * scale)
			
					-- rotate the object centre around the pinch centre
					-- (same rotation as the object is rotated!)
					--pt = rotateAboutPoint( pt, centre, rotate, false )
			
					-- apply pinch translation, scaling and rotation to the object centre
					object.x, object.y = pt.x, pt.y

				end
				-- store the centre of all touch points
				object.prevCentre = centre
				
			else -- "ended" and "cancelled" phases
			
				-- remove the tracking dot from the list
				if (isDevice or pinchZoom.simulateMultitouch==false or e.numTaps == 2) then
					-- get index of dot to be removed
					local index = table.indexOf( object.dots, e.target )
				
					-- remove dot from list
					table.remove( object.dots, index )
				
					-- remove tracking dot from the screen
					e.target:removeSelf()
				
					-- store the new centre of all touch points
					object.prevCentre = calcAvgCentre( object.dots )
				
					-- refresh tracking dot scale and rotation values
					updateTracking( object.prevCentre, object.dots )
					
					if #object.dots == 0 then
						display.remove(object.catchAll)
						if params.singleTouch == true then
							system.deactivate("multitouch")
						end
					end
				end
				if params.followup~=nil then params.followup(object) end
			end
			return true
		end
	
		-- if the target is not responsible for this touch event return false
		return false
	end

	-- attach pinch zoom touch listener
	object.touch = touch

	-- listen for touches starting on the touch object
	object:addEventListener("touch")

end

return pinchZoom