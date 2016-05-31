------------------------------------------------------------------------------------
-- INITIALIZE SCENE & LOAD LIBRARIES
------------------------------------------------------------------------------------
local composer = require "composer"
local scene = composer.newScene()
local settings = require("utilities.settings")
	
local sheetInfo = require("images.home")
local imageSheet = graphics.newImageSheet( "images/home.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( imageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )

------------------------------------------------------------------------------------
-- VARIABLE DECLARATIONS
------------------------------------------------------------------------------------

-- DISPLAY GROUPS
	local group

-- DISPLAY OBJECTS
	local bg, logo, tapToStart, minorDistractions

-- FUNCTIONS
	local logoLoop, goBuild

-- SOUNDS
	local sounds = {}

-- OTHER
	

------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------

function logoLoop()
	if logo.xScale==1 then
		transition.to(logo, {xScale = .9, yScale = .9, time = 3000, onComplete = logoLoop})
	else
		transition.to(logo, {xScale = 1, yScale = 1, time = 3000, onComplete = logoLoop})
	end
	print("loop")
end

function goBuild()
	composer.gotoScene("scenes.build", "crossFade")
end



------------------------------------------------------------------------------------
-- CREATE SCENE
------------------------------------------------------------------------------------
function scene:create( event )
	group = self.view
	
	bg = display.newRect(group, 0, 0, screenWidth, screenHeight)
	bg.x, bg.y = centerX, centerY
	bg.fill = {
		type = "gradient",
		color1 = { 1, 17/255, 2/255, 1 },
		color2 = { 1, 237/255, 0, 1 },
		direction = "down"
	}
	bg:addEventListener("tap", goBuild)
	
	logo = display.newImageRect(group, imageSheet, sheetInfo:getFrameIndex("CFLogo"), 694, 532)
		logo.x, logo.y = centerX, centerY
	
	minorDistractions = display.newImageRect(group, imageSheet, sheetInfo:getFrameIndex("minorDistractions"), 276, 91)
		minorDistractions.anchorX, minorDistractions.anchorY = 0, 0
		minorDistractions.x, minorDistractions.y = screenLeft + 20, screenTop + 20
	
	tapToStart = display.newText(group, "Tap Anywhere to Begin", 0, 0, "HouseofTerror", 62)
		tapToStart:setFillColor(0,0,0)
		tapToStart.anchorX, tapToStart.anchorY = .5, 1
		tapToStart.x, tapToStart.y = centerX, screenBottom-10
	

end

------------------------------------------------------------------------------------
-- SHOW SCENE
------------------------------------------------------------------------------------
function scene:show( event )
	if event.phase=="will" then
		-- just before scene is made visible
		logoLoop()
		
	elseif event.phase=="did" then
		-- just after scene is made visible
		timer.performWithDelay(1, function()composer.removeHidden() end)
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
		transition.cancel(logo)
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

end

------------------------------------------------------------------------------------
-- COMPOSER LISTENERS
------------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene