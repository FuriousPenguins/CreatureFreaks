------------------------------------------------------------------------------------
-- INITIALIZE SCENE & LOAD LIBRARIES
------------------------------------------------------------------------------------
local composer = require "composer"
local scene = composer.newScene()

local navWheel = require("utilities.navWheel")
local settings = require("utilities.settings")
local activeCreature = require("utilities.activeCreature")

------------------------------------------------------------------------------------
-- VARIABLE DECLARATIONS
------------------------------------------------------------------------------------

-- DISPLAY GROUPS
	local group
	local creatureGroup = display.newGroup()
	creatureGroup.alpha = 0

-- DISPLAY OBJECTS
	local sheetInfo = require("images.dungeon")
	local imageSheet = graphics.newImageSheet( "images/dungeon.png", sheetInfo:getSheet() )
	local bg, wheel, playBG, buildBG, nameplate, nameText

-- FUNCTIONS
	local wheelListener, changeName

-- SOUNDS
	local sounds = {
		wheelSpin = audio.loadSound("audio/wheelSpin.wav"),
	}

-- OTHER
	

------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------

function wheelListener(event)
	audio.play(sounds.wheelSpin)
	if event.direction == "clockwise" then
		transition.to(buildBG, {x = screenRight + ((buildBG.width - screenWidth)*.5), time = 1800, onComplete = function()
			composer.gotoScene("scenes.build")
		end})
	elseif event.direction == "counterclockwise" then
		transition.to(playBG, {x = screenLeft, time = 1800, onComplete = function()
			composer.gotoScene("scenes.play")
		end})
	end
end

function changeName(e)
	if e.phase == "began" then
		-- forward declare function variables
		local keyboardListener, textField
	
		function keyboardListener( event )
			if event.phase == "editing" then
				nameText.text = event.text
				nameText.x, nameText.y = nameplate.x, nameplate.y
			elseif event.phase=="submitted" then
				activeCreature.name = nameText.text
				native.setKeyboardFocus(nil)
				display.remove(textField)
			end
		end
		
		textField = native.newTextField( centerX, centerY + screenHeight, screenWidth, 100 )
		textField.text = nameText.text
		textField:addEventListener( "userInput", keyboardListener )
		if system.getInfo("environment")=="simulator" then textField.y = centerY end
		
		native.setKeyboardFocus( textField )
	end
end

------------------------------------------------------------------------------------
-- CREATE SCENE
------------------------------------------------------------------------------------
function scene:create( event )
	group = self.view
	
	-- create background
	bg = display.newImage(group, "images/dungeonBG.jpg", true)
	bg.x, bg.y = centerX, centerY
	
	-- add creature
	creature = activeCreature.loadStatic()
	creature.x, creature.y = centerX, centerY
	local scale = 1
	if creature.width > screenWidth*.3 then
		scale = screenWidth*.3 / creature.width
		creature.xScale, creature.yScale = scale, scale
	end
	if creature.contentHeight > screenHeight *.7 then
		scale = scale * (screenHeight*.7/creature.contentHeight)
		creature.xScale, creature.yScale = scale, scale
	end
	creatureGroup:insert(creature)
	
	-- add nameplate
	nameplate = display.newImage(creatureGroup, imageSheet, sheetInfo:getFrameIndex("nameplate"))
	nameplate.x, nameplate.y = centerX, centerY-screenHeight*.4
	group:insert(creatureGroup)
	
	nameText = display.newText(creatureGroup, activeCreature.name, nameplate.x, nameplate.y, "HouseofTerror", 40)
	
	nameplate:addEventListener("touch", changeName)
	
	-- adjacent scene backgrouds
	playBG = display.newRect(group, screenRight, centerY, screenWidth, screenHeight)
	playBG.anchorX = 0
	playBG.fill = {
		type = "gradient",
		color1 = { 1, 17/255, 2/255, 1 },
		color2 = { 1, 237/255, 0, 1 },
		direction = "down"
	}
	
	buildBG = display.newImage(group, "images/buildBG.jpg", true)
	buildBG.anchorX = 1
	buildBG.x, buildBG.y = screenLeft, centerY
	
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
		
	elseif event.phase=="did" then
		-- just after scene is made visible
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