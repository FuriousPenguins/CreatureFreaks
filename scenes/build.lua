------------------------------------------------------------------------------------
-- INITIALIZE SCENE & LOAD LIBRARIES
------------------------------------------------------------------------------------
local composer = require "composer"
local scene = composer.newScene()
local physics = require "physics"
physics.start()
physics.setGravity(0,0)
local widget = require "widget"
local pinchZoom = require("utilities.pinchZoom")
pinchZoom.simulateMultitouch = false
local navWheel = require("utilities.navWheel")
local parts = require "utilities.parts"
local settings = require("utilities.settings")
local activeCreature = require("utilities.activeCreature")

------------------------------------------------------------------------------------
-- VARIABLE DECLARATIONS
------------------------------------------------------------------------------------

-- DISPLAY GROUPS
	local group
	local creatureGroup = display.newGroup()
	creatureGroup.alpha = 0
	local buttonGroup = display.newGroup()
		buttonGroup.x, buttonGroup.y = screenRight + screenWidth, screenTop
	local cabinet = display.newGroup()
		cabinet.x, cabinet.y = screenLeft - screenWidth, screenTop

-- DISPLAY OBJECTS
	local sheetInfo = require("images.build")
	local imageSheet = graphics.newImageSheet( "images/build.png", sheetInfo:getSheet() )
	local bg, backButton, flipButton, deleteButton, wheel, buttonShadow, partShadow, partFade, CFLogo, dungeonBG, playBG

-- FUNCTIONS
	local onEnterFrame, back, flip, delete, categoryTouch, drawerPartTouch, partTap, smokePuff, wheelListener, followup

-- SOUNDS
	local sounds = {
		cabinetClick = audio.loadSound("audio/cabinetClick.wav"),
		drawerOpen = audio.loadSound("audio/drawerOpen.wav"),
		drawerClose = audio.loadSound("audio/drawerClose.wav"),
		back = audio.loadSound("audio/back.wav"),
		delete = audio.loadSound("audio/delete.wav"),
		flip = audio.loadSound("audio/flip.wav"),
		wheelSpin = audio.loadSound("audio/wheelSpin.wav"),
	}

-- OTHER
	local activePart

------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------

function onEnterFrame()
	-- keep partGroup static pieces in-place
	partShadow.x = cabinet.x + 128
	partFade.x = cabinet.x
	CFLogo.x = cabinet.x
	
	-- keep parts group scrolling infinitely
	local topPart = cabinet[1]
	local bottomPart = cabinet[cabinet.numChildren]
	local topX, topY = topPart:contentToLocal(0,-64)
	local bottomX, bottomY = bottomPart:contentToLocal(0,-64)
	
	if topY>screenTop+((cabinet.height - screenHeight)*.5) then
		topPart.y = bottomPart.y + 128
		topPart:toFront()
		if cabinet.x>=screenLeft-2 then audio.play(sounds.cabinetClick) end
	end
	
	if bottomY<-screenBottom-((cabinet.height - screenHeight)*.5) then
		bottomPart.y = topPart.y - 128
		bottomPart:toBack()
		if cabinet.x>=screenLeft-2 then audio.play(sounds.cabinetClick) end
	end
end

function wheelListener(event)
	audio.play(sounds.wheelSpin)
	if event.direction == "clockwise" then
		transition.to(playBG, {x = screenRight, time = 1800, onComplete = function()
			composer.gotoScene("scenes.play")
		end})
	elseif event.direction == "counterclockwise" then
		transition.to(dungeonBG, {x = screenLeft - ((dungeonBG.width - screenWidth)*.5), time = 1800, onComplete = function()
			composer.gotoScene("scenes.dungeon")
		end})
	end
end

function smokePuff(x, y)
	local function spriteListener(event)
		local phase = event.phase
		local target = event.target
		
		if phase == "ended" then
			display.remove(target)
			target = nil
		end
	end
	
	local sequenceData = {
		name="smokePuff",
		frames= {
			sheetInfo:getFrameIndex("smoke1"),
			sheetInfo:getFrameIndex("smoke2"),
			sheetInfo:getFrameIndex("smoke3"),
			sheetInfo:getFrameIndex("smoke4"),
			sheetInfo:getFrameIndex("smoke5"),
			sheetInfo:getFrameIndex("smoke6"),
			sheetInfo:getFrameIndex("smoke7"),
			sheetInfo:getFrameIndex("smoke8"),
			sheetInfo:getFrameIndex("smoke9"),
			sheetInfo:getFrameIndex("smoke10"),
		},
		loopCount = 1,
		time = 400,
	}

	local puff = display.newSprite( imageSheet, sequenceData )
	puff.x, puff.y = x, y
	puff:addEventListener("sprite", spriteListener)
	puff:play()
end

function partTap(event)
	local target = event.target
	
	for k,v in pairs(parts.categories) do
		local category = k
		if cabinet[category].button.sequence == "on" then
			audio.play(sounds.drawerClose)
			cabinet[category].button:setSequence("off")
			transition.to(cabinet[category].drawers, {x = screenLeft - cabinet[category].drawers.width, time = 900, transition = easing.inOutBack})
		end
	end
	
	for i = creatureGroup.numChildren, 1, -1 do
		creatureGroup[i]:setFillColor(1,1,1,1)
		creatureGroup[i].isActivePart = false
	end
	
	if target.parent == creatureGroup and target ~= activePart then
		target.isActivePart = true
		target:setFillColor(1,0,0,.9)
		activePart = target
		transition.to(buttonGroup, {x = screenRight, transition = easing.outExpo, time = 300})
	else
		activePart = nil
		transition.to(buttonGroup, {x = screenRight + screenWidth, transition = easing.inExpo, time = 300})
	end
	return true
end

function back(event)
	if activePart ~= nil then
		local index = 0
		for i = creatureGroup.numChildren, 1, -1 do
			if creatureGroup[i] == activePart then index = i end
		end
		if index >1 then
			creatureGroup:insert(index-1, activePart)
		end
		audio.play(sounds.back)
		activeCreature.update(creatureGroup)
	end
	return true
end

function flip(event)
	if activePart ~= nil and activePart.trans == nil then
		activePart.trans = transition.to(activePart, {xScale = -activePart.xScale, time = 400, transition = easing.inOutBack, onComplete = function()activeCreature.update(creatureGroup); activePart.trans = nil end})
		audio.play(sounds.flip)
	end
	return true
end

function delete(event)
	if activePart ~= nil then
		local function remove()
			if activePart == creatureGroup.body then creatureGroup.body = nil end
			local x, y = activePart:localToContent(activePart.x, activePart.y)
			smokePuff(x, y)
			display.remove(activePart)
			activePart = nil
			audio.play(sounds.delete)
			activeCreature.update(creatureGroup)
		end
		transition.to(buttonGroup, {x = screenRight + screenWidth, transition = easing.inExpo, time = 300})
		transition.to(activePart, {xScale = .01, yScale = .01, time = 300, transition = easing.inBack, onComplete = remove})
	end
end

function categoryTouch(event)
	local target = event.target
	local phase = event.phase
	
	if phase=="began" then
		target.touchBegan = true
		display.getCurrentStage():setFocus(target, event.id)
		cabinet.joint = physics.newJoint("touch", cabinet, event.x, event.y)
	elseif phase=="moved" and target.touchBegan==true then
		for k,v in pairs(parts.categories) do
			local category = k
			cabinet[category].button:setSequence("off")
			if cabinet[category].drawers.x == 128 then
				transition.to(cabinet[category].drawers, {x = screenLeft - cabinet[category].drawers.width, time = 800, transition = easing.inOutBack})
				audio.play(sounds.drawerClose)
			end
		end
		cabinet.joint:setTarget(event.xStart, event.y)
	elseif (phase=="ended" or phase=="cancelled") and target.touchBegan==true then
		target.touchBegan = nil
		display.getCurrentStage():setFocus(nil, event.id)
		cabinet.joint:removeSelf()
		cabinet.joint = nil
	end
	
	return true
end

function categoryTap(event)
	audio.stop()
	local target = event.target
	transition.cancel(target.parent.drawers)

	for k,v in pairs(parts.categories) do
		local category = k
		if cabinet[category].button ~= target then
			cabinet[category].button:setSequence("off")
			transition.to(cabinet[category].drawers, {x = screenLeft - cabinet[category].drawers.width, time = 200, transition = easing.inOutBack})
		end
	end
	if target.sequence == "on" then
		target:setSequence("off")
		transition.to(target.parent.drawers, {x = -target.parent.drawers.width, time = 900, transition = easing.inOutBack})
		audio.play(sounds.drawerClose)
	else
		target:setSequence("on")
		transition.to(target.parent.drawers, {x = 128, time = 400, transition = easing.inOutBack})
		audio.play(sounds.drawerOpen)
	end

	local newX, newY = target:localToContent(0, -target.height*.5)
	transition.to(cabinet, {y = cabinet.y - newY, x = screenLeft, time = 400})
	
	return true
end

function followup(part)
	if part.category == "body" then
		if creatureGroup.body ~= nil and creatureGroup.body ~= part then
			local index = creatureGroup.numChildren
			local x, y = creatureGroup.body.x, creatureGroup.body.y
			for i = 1,creatureGroup.numChildren do
				if creatureGroup[i] == creatureGroup.body then index = i end
			end
			activePart = creatureGroup.body
			delete()
			creatureGroup.body = part
			creatureGroup:insert(index, part)
			part.x, part.y = x, y
		elseif creatureGroup.body == nil then
			creatureGroup.body = part
		end
	end
	activeCreature.update(creatureGroup)
	return true
end

function drawerPartTouch(self, event)
	local target = self
	local phase = event.phase
	
	local function popOut()
		local part = parts.new(self.partName)
		part.x, part.y = creatureGroup:contentToLocal(event.x, event.y)
		pinchZoom.add(part, {maxScale = 2, minScale = .75, singleTouch = true, followup = followup})
		creatureGroup:insert(part)
		part:addEventListener("tap", partTap)
		local newEvent = event
		newEvent.target = part
		newEvent.phase = "began"
		part:dispatchEvent(newEvent)
	end
	
	if phase=="began" then
		for i=1,#parts.categories do
			local category = parts.categories[i]
			cabinet[category].button:setSequence("off")
			if cabinet[category].drawers.x == 128 then
				transition.to(cabinet[category].drawers, {x = screenLeft - cabinet[category].drawers.width, time = 800, transition = easing.inOutBack})
				audio.play(sounds.drawerClose)
			end
		end
		popOut()
	end
	return true
end


------------------------------------------------------------------------------------
-- CREATE SCENE
------------------------------------------------------------------------------------
function scene:create( event )
	group = self.view
	
	-- create background
	bg = display.newImage(group, "images/buildBG.jpg", true)
	bg.x, bg.y = centerX, centerY
	bg:addEventListener("tap", partTap)
	
	-- create right-hand "button group"
	backButton = widget.newButton{
		sheet = imageSheet,
		defaultFrame = sheetInfo:getFrameIndex("back1"),
		overFrame = sheetInfo:getFrameIndex("back2"),
		onRelease = back
	}
	backButton.anchorX, backButton.anchorY = 1, 0
	backButton.x, backButton.y = 0, 0
	buttonGroup:insert(backButton)
	
	flipButton = widget.newButton{
		sheet = imageSheet,
		defaultFrame = sheetInfo:getFrameIndex("flip1"),
		overFrame = sheetInfo:getFrameIndex("flip2"),
		onRelease = flip
	}
	flipButton.anchorX, flipButton.anchorY = 1, 0
	flipButton.x, flipButton.y = 0, backButton.y + backButton.height
	buttonGroup:insert(flipButton)
	
	deleteButton = widget.newButton{
		sheet = imageSheet,
		defaultFrame = sheetInfo:getFrameIndex("delete1"),
		overFrame = sheetInfo:getFrameIndex("delete2"),
		onRelease = delete
	}
	deleteButton.anchorX, deleteButton.anchorY = 1, 0
	deleteButton.x, deleteButton.y = 0, flipButton.y + flipButton.height
	buttonGroup:insert(deleteButton)
		
	buttonShadow = display.newImage(buttonGroup, imageSheet, sheetInfo:getFrameIndex("buttonShadow"))
	buttonShadow.anchorX, buttonShadow.anchorY = 1, 0
	buttonShadow.x, buttonShadow.y = 0, deleteButton.y + deleteButton.height
	
	buttonGroup:addEventListener("tap", function()return true end)
	
	-- create left-hand "cabinet"
	local i = 0
	for k,v in pairs(parts.categories) do
		i = i+1
		local category = k
		local categoryGroup = display.newGroup()
		categoryGroup.x, categoryGroup.y = 0, 128*i - 128
		
		local drawerGroup = display.newGroup()
		
		local extraDrawer = display.newImage(drawerGroup, imageSheet, sheetInfo:getFrameIndex("drawer"))
				extraDrawer.anchorX, extraDrawer.anchorY = 0, 0
				extraDrawer.x, extraDrawer.y = -128, 0
		
		for z=1,#v do
			local drawer = display.newImage(drawerGroup, imageSheet, sheetInfo:getFrameIndex("drawer"))
				drawer.anchorX, drawer.anchorY = 0, 0
				drawer.x, drawer.y = 128*z - 128, 0
				
			local part = parts.new(v[z])
			part.anchorX, part.anchorY = .5, .5
			part.x, part.y = drawer.x + drawer.width*.5, drawer.y + drawer.height*.5
			part.touch = drawerPartTouch
			part:addEventListener("touch")
			drawerGroup:insert(part)
			
			local scale = 1
			if part.height > 80 then scale = 80/part.height end
			if part.width * scale > 80 then scale = 80/part.width end
			part.xScale, part.yScale = scale, scale
		end
		
		drawerGroup.x = -drawerGroup.width
		categoryGroup:insert(drawerGroup)
		
		local button = display.newSprite(categoryGroup, imageSheet, {
			{name="off", start=sheetInfo:getFrameIndex(category.."1"), count = 1},
			{name="on", start=sheetInfo:getFrameIndex(category.."2"), count = 1}
		})
			button.anchorX, button.anchorY = 0, 0
			button.x, button.y = 0, 0
			button.category = category
			button:addEventListener("touch", categoryTouch)
			button:addEventListener("tap", categoryTap)
			
		categoryGroup.button = button
		categoryGroup.drawers = drawerGroup
		cabinet[category] = categoryGroup
		cabinet:insert(categoryGroup)
	end
	
	group:insert(creatureGroup)
	group:insert(cabinet)
	
	partShadow = display.newImage(group, imageSheet, sheetInfo:getFrameIndex("partShadow"))
	partShadow.height = screenHeight
	partShadow.anchorX, partShadow.anchorY = 0, 0
	partShadow.x, partShadow.y = 128, screenTop
	
	partFade = display.newRect(group, 0, 0, 151, screenHeight)
	partFade.fill = {type = "gradient", color1 = {0,0,0,.9}, color2 = {0,0,0,0}, direction = "up"}
	partFade.blendMode = "multiply"
	partFade.anchorX, partFade.anchorY = 0, 0
	partFade.x, partFade.y = 0, 0
	
	CFLogo = display.newImage(group, imageSheet, sheetInfo:getFrameIndex("CFLogo"))
	CFLogo.anchorX, CFLogo.anchorY = 0, 1
	CFLogo.x, CFLogo.y = screenLeft, screenBottom
		
	physics.addBody(cabinet)
	cabinet.isSensor = true
	cabinet.isFixedRotation = true
	cabinet.linearDamping = 5
	cabinet.gravityScale = 0
	
	group:insert(buttonGroup)
	
	playBG = display.newRect(group, screenLeft, centerY, screenWidth, screenHeight)
	playBG.anchorX = 1
	playBG.fill = {
		type = "gradient",
		color1 = { 1, 17/255, 2/255, 1 },
		color2 = { 1, 237/255, 0, 1 },
		direction = "down"
	}
	
	dungeonBG = display.newImage(group, "images/dungeonBG.jpg", true)
	dungeonBG.anchorX = 0
	dungeonBG.x, dungeonBG.y = screenRight, centerY
	
	-- create navigation wheel
	wheel = navWheel.new()
	wheel.x, wheel.y = screenRight, screenBottom
	group:insert(wheel.group)
	wheel:addEventListener("spin", wheelListener)
end

------------------------------------------------------------------------------------
-- SHOW SCENE
------------------------------------------------------------------------------------
function scene:show( event )
	if event.phase=="will" then
		-- just before scene is made visible
		Runtime:addEventListener("enterFrame", onEnterFrame)
		activeCreature.load(creatureGroup, true)
		for i = creatureGroup.numChildren, 1, -1 do
			local part = creatureGroup[i]
			pinchZoom.add(part, {maxScale = 2, minScale = .75, singleTouch = true, followup = followup})
			part:addEventListener("tap", partTap)
		end
	elseif event.phase=="did" then
		-- just after scene is made visible
		transition.to(cabinet, {x = screenLeft, transition = easing.outExpo})
		timer.performWithDelay(1, function()composer.removeHidden() end)
		transition.to(creatureGroup, {alpha = 1})
	end
end

------------------------------------------------------------------------------------
-- HIDE SCENE
------------------------------------------------------------------------------------
function scene:hide( event )
	if event.phase=="will" then
		-- just before scene is taken off-screen
		
	elseif event.phase=="did" then
		-- just after scene is taken off-screen
		Runtime:removeEventListener("enterFrame", onEnterFrame)
		
	end
end

------------------------------------------------------------------------------------
-- DESTROY SCENE
------------------------------------------------------------------------------------
function scene:destroy( event )
	-- remove sounds from memory
	for k,v in pairs(sounds) do
		audio.dispose(sounds[k])
		sounds[k] = nil
	end
	wheel:remove()
end

------------------------------------------------------------------------------------
-- COMPOSER LISTENERS
------------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene