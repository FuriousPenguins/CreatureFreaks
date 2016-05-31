------------------------------------------------------------------------------------
-- INITIALIZE
------------------------------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar )
math.randomseed( os.time() )

------------------------------------------------------------------------------------
-- ALLOW BACKGROUND MUSIC FROM OTHER APPS
------------------------------------------------------------------------------------
if audio.supportsSessionProperty then  
    audio.setSessionProperty(audio.MixMode, audio.AmbientMixMode)
end

------------------------------------------------------------------------------------
-- NULLIFLY PRINT FUNCTION (uncomment when building for distribution)
------------------------------------------------------------------------------------
--print = function() end

------------------------------------------------------------------------------------
-- LOAD EXTERNAL LIBRARIES/MODULES
------------------------------------------------------------------------------------
local composer = require ("composer")
local settings = require ("utilities.settings")

------------------------------------------------------------------------------------
-- DELARE GLOBAL VARIABLES
------------------------------------------------------------------------------------
centerX = display.contentCenterX
centerY = display.contentCenterY
screenTop = display.screenOriginY
screenLeft = display.screenOriginX
screenBottom = display.screenOriginY+(display.contentHeight-(display.screenOriginY*2))
screenRight = display.screenOriginX+(display.contentWidth-(display.screenOriginX*2))
screenWidth = screenRight - screenLeft
screenHeight = screenBottom - screenTop

------------------------------------------------------------------------------------
-- LOAD SETTINGS (OR SET DEFAULTS IF FIRST LAUNCH)
------------------------------------------------------------------------------------
settings.load()

-- CHECK FOR SOUND ON/OFF PREFERENCES:
if settings.soundOn == true then
	audio.setVolume(1) 
else
	audio.setVolume(0)
end


------------------------------------------------------------------------------------
-- GO TO FIRST SCENE
------------------------------------------------------------------------------------
composer.gotoScene("scenes.home")