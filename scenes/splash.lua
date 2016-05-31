------------------------------------------------------------------------------------
-- INITIALIZE SCENE & LOAD LIBRARIES
------------------------------------------------------------------------------------
local composer = require "composer"
	local scene = composer.newScene()

------------------------------------------------------------------------------------
-- VARIABLE DECLARATIONS
------------------------------------------------------------------------------------

-- DISPLAY GROUPS
	local group

-- DISPLAY OBJECTS
	local bg, intro

-- FUNCTIONS
	local videoListener

-- SOUNDS
	local sounds = {}

-- OTHER
	

------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------

function videoListener( event )
	if event.phase == "ended" then
		composer.gotoScene("scenes.home")
	end
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
	
	intro = native.newVideo(centerX, centerY, 1364, 768)
	intro:load( "videos/intro.mp4", system.ResourceDirectory)
	intro:addEventListener( "video", videoListener )
	
end

------------------------------------------------------------------------------------
-- SHOW SCENE
------------------------------------------------------------------------------------
function scene:show( event )
	if event.phase=="will" then
		-- just before scene is made visible
		
	elseif event.phase=="did" then
		-- just after scene is made visible
		if system.getInfo("environment") == "simulator" then
			composer.gotoScene("scenes.home")
		else
			intro:play()
		end
	end
end

------------------------------------------------------------------------------------
-- HIDE SCENE
------------------------------------------------------------------------------------
function scene:hide( event )
	if event.phase=="will" then
		-- just before scene is taken off-screen
		if intro~=nil then
			intro:removeSelf()
			intro = nil
		end
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

end

------------------------------------------------------------------------------------
-- COMPOSER LISTENERS
------------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene