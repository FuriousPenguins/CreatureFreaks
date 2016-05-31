local navWheel = {}
local physics = require("physics")
physics.start()

function navWheel.new()
	local group = display.newGroup()
	
	local wheel = display.newImage(group, "images/wheel.png")
	wheel.x, wheel.y = 0, 0
	physics.addBody(wheel)
	wheel.angularDamping = 10
	wheel.isSensor = true
	
	local pin = display.newCircle(group, 0, 0, 20)
	pin.isVisible = false
	physics.addBody(pin, "static")
	pin.isSensor = true
	physics.newJoint("pivot", wheel, pin, group.x, group.y)
	
	function wheel.touch(self, event)
		local target = self
		local phase = event.phase
	
		if phase == "began" then
			target.isFixedRotation = false
			target.startRotation = target.rotation
			display.getCurrentStage():setFocus(target, event.id)
			target.hasFocus = true
			target.touchJoint = physics.newJoint("touch", target, event.x, event.y)
		elseif phase == "moved" and target.hasFocus then
			target.touchJoint:setTarget(event.x, event.y)
		elseif (phase == "cancelled" or phase == "ended") and target.hasFocus then
			display.getCurrentStage():setFocus(nil, event.id)
			target.touchJoint:removeSelf()
			target.touchJoint = nil
			target.hasFocus = false
			if target.rotation >= target.startRotation  + 35 then
				wheel:removeEventListener("touch")
				transition.to(wheel, {rotation = 360, time = 1800})
				pin:dispatchEvent({name = "spin", direction = "clockwise"})
			elseif target.rotation <= target.startRotation - 35 then
				wheel:removeEventListener("touch")
				transition.to(wheel, {rotation = -360, time = 1800})
				pin:dispatchEvent({name = "spin", direction = "counterclockwise"})
			else
				target.isFixedRotation = true
				transition.to(target, {rotation = 0, time = 100})
			end
		end
		return true
	end
	
	wheel:addEventListener("touch")
	
	function pin:remove()
		display.remove(group)
		print("REMOVED")
	end
	
	pin.group = group
	return pin
end


return navWheel