local activeCreature = {}
local parts = require("utilities.parts")
local pinchZoom = require("utilities.pinchZoom")
local settings = require("utilities.settings")

activeCreature.name = "New Creature"
activeCreature.parts = {}

function activeCreature.update(group)
	activeCreature.parts = {}
	for i = group.numChildren, 1, -1 do
		local part = group[i]
		local partData = {}
		partData.partName = part.partName
		partData.x = part.x
		partData.y = part.y
		partData.xScale = part.xScale
		partData.yScale = part.yScale
		partData.rotation = part.rotation
		activeCreature.parts[i] = partData
	end
end

function activeCreature.load(group)
	for i = 1, #activeCreature.parts do
		local partData = activeCreature.parts[i]
		local part = parts.new(partData.partName)
		part.x = partData.x
		part.y = partData.y
		part.xScale = partData.xScale
		part.yScale = partData.yScale
		part.rotation = partData.rotation
		group:insert(part)
	end
end

function activeCreature.loadStatic()
	local group = display.newGroup()
	group.anchorChildren = true
	for i = 1, #activeCreature.parts do
		local partData = activeCreature.parts[i]
		local part = parts.new(partData.partName)
		part.x = partData.x - centerX
		part.y = partData.y - centerY
		part.xScale = partData.xScale
		part.yScale = partData.yScale
		part.rotation = partData.rotation
		group:insert(part)
	end
	
	return group
end

function activeCreature.loadBWStatic()
	local group = display.newGroup()
	group.anchorChildren = true
	for i = 1, #activeCreature.parts do
		local partData = activeCreature.parts[i]
		local part = parts.new(partData.partName, true)
		part.x = partData.x - centerX
		part.y = partData.y - centerY
		part.xScale = partData.xScale
		part.yScale = partData.yScale
		part.rotation = partData.rotation
		group:insert(part)
	end
	
	return group
end

return activeCreature