local parts = {}

------------------------------------------------------------------------------------
-- SPRITE SHEETS
------------------------------------------------------------------------------------
local colorSheetInfo = require("images.parts")
local colorImageSheet = graphics.newImageSheet( "images/parts.png", colorSheetInfo:getSheet() )

local bwSheetInfo = require("images.partsBW")
local bwImageSheet = graphics.newImageSheet( "images/partsBW.png", colorSheetInfo:getSheet() )

------------------------------------------------------------------------------------
-- DEFINE PART CATEGORIES
------------------------------------------------------------------------------------
parts.categories = {
	body = {"body1", "body2", "body3"},
	head = {"head1", "head2", "head3"},
	eye = {"eye1", "eye2", "eye3"},
	ear = {"ear1", "ear2", "ear3"},
	mouth = {"mouth1", "mouth2", "mouth3"},
	horn = {"horn1", "horn2", "horn3"},
	arm = {"arm1", "arm2", "arm3"},
	leg = {"leg1", "leg2", "leg3"},
	tail = {"tail1", "tail2", "tail3"},
	wing = {"wing1", "wing2", "wing3"},
}

------------------------------------------------------------------------------------
-- BODIES
------------------------------------------------------------------------------------
parts.body1 = {
	category = "body",
	description = "fuzzy heart",
	anchorX = 296/556,
	anchorY = 537/959,
}

parts.body2 = {
	category = "body",
	description = "turtle body",
	anchorX = 338/631,
	anchorY = 505/833,
}

parts.body3 = {
	category = "body",
	description = "seashell body",
	anchorX = 260/527,
	anchorY = 500/955,
}

------------------------------------------------------------------------------------
-- HEADS
------------------------------------------------------------------------------------
parts.head1 = {
	category = "head",
	description = "green dome",
	anchorX = 291/576,
	anchorY = 215/408,
}
	
parts.head2 = {
	category = "head",
	description = "fuzzy head",
	anchorX = 316/631,
	anchorY = 238/475,
}

parts.head3 = {
	category = "head",
	description = "octopus head",
	anchorX = 391/801,
	anchorY = 274/860,
}

------------------------------------------------------------------------------------
-- EYES
------------------------------------------------------------------------------------
parts.eye1 = {
	category = "eye",
	description = "angry eye",
	anchorX = 141/242,
	anchorY = 122/182,
}

parts.eye2 = {
	category = "eye",
	description = "tentacle eye",
	anchorX = 165/204,
	anchorY = 346/382,
}

parts.eye3 = {
	category = "eye",
	description = "eyelash eye",
	anchorX = 98/186,
	anchorY = 98/184,
}

------------------------------------------------------------------------------------
-- EARS
------------------------------------------------------------------------------------
parts.ear1 = {
	category = "ear",
	description = "spiny ear",
	anchorX = 45/246,
	anchorY = 396/408,
}

parts.ear2 = {
	category = "ear",
	description = "rabbit ear",
	anchorX = 16/354,
	anchorY = 479/489,
}

parts.ear3 = {
	category = "ear",
	description = "eagle ear",
	anchorX = 218/228,
	anchorY = 218/262,
}


------------------------------------------------------------------------------------
-- MOUTHS
------------------------------------------------------------------------------------
parts.mouth1 = {
	category = "mouth",
	description = "",
	anchorX = .5,
	anchorY = .5,
}

parts.mouth2 = {
	category = "mouth",
	description = "",
	anchorX = .5,
	anchorY = .5,
}

parts.mouth3 = {
	category = "mouth",
	description = "",
	anchorX = .5,
	anchorY = .5,
}

------------------------------------------------------------------------------------
-- HORNS
------------------------------------------------------------------------------------
parts.horn1 = {
	category = "horn",
	description = "bull horn",
	anchorX = 270/292,
	anchorY = 288/348,
}

parts.horn2 = {
	category = "horn",
	description = "fraggle horn",
	anchorX = 131/190,
	anchorY = 284/299,
}

parts.horn3 = {
	category = "horn",
	description = "antennae",
	anchorX = 236/212,
	anchorY = 189/212,
}

------------------------------------------------------------------------------------
-- ARMS
------------------------------------------------------------------------------------
parts.arm1 = {
	category = "arm",
	description = "crab claw",
	anchorX = 541/564,
	anchorY = 34/745,
}

parts.arm2 = {
	category = "arm",
	description = "werewolf arm",
	anchorX = 417/440,
	anchorY = 65/733,
}

parts.arm3 = {
	category = "arm",
	description = "yeti arm",
	anchorX = 315/336,
	anchorY = 30/544,
}

------------------------------------------------------------------------------------
-- LEGS
------------------------------------------------------------------------------------
parts.leg1 = {
	category = "leg",
	description = "dinosaur leg",
	anchorX = 292/372,
	anchorY = 66/699,
}

parts.leg2 = {
	category = "leg",
	description = "goat leg",
	anchorX = 258/291,
	anchorY = 61/861,
}

parts.leg3 = {
	category = "leg",
	description = "frog leg",
	anchorX = 400/475,
	anchorY = 30/792,
}

------------------------------------------------------------------------------------
-- TAILS
------------------------------------------------------------------------------------
parts.tail1 = {
	category = "tail",
	description = "green tail",
	anchorX = 1126/1200,
	anchorY = 361/714,
}

parts.tail2 = {
	category = "tail",
	description = "lion tail",
	anchorX = 16/1119,
	anchorY = 80/492,
}

parts.tail3 = {
	category = "tail",
	description = "orange tail",
	anchorX = 56/1116,
	anchorY = 757/857,
}

------------------------------------------------------------------------------------
-- WINGS
------------------------------------------------------------------------------------
parts.wing1 = {
	category = "wing",
	description = "butterfly wings",
	anchorX = 1024/1051,
	anchorY = 866/1967,
}

parts.wing2 = {
	category = "wing",
	description = "angel wings",
	anchorX = 620/638,
	anchorY = 830/904,
}

parts.wing3 = {
	category = "wing",
	description = "demon wings",
	anchorX = 19/965,
	anchorY = 622/912,
}

------------------------------------------------------------------------------------
-- NEW PART FUNCTION
------------------------------------------------------------------------------------
function parts.new(partName, BW)
	local part
	if BW == true then
		part = display.newImage(bwImageSheet, bwSheetInfo:getFrameIndex(partName))
	else
		part = display.newImage(colorImageSheet, colorSheetInfo:getFrameIndex(partName))
	end
	for k,v in pairs(parts[partName]) do
		part[k] = v
		part.partName = partName
	end
	return part
end


return parts