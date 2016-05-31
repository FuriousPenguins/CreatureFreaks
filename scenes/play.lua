------------------------------------------------------------------------------------
-- INITIALIZE SCENE & LOAD LIBRARIES
------------------------------------------------------------------------------------
local composer = require "composer"
local scene = composer.newScene()

local widget = require("widget")
local settings = require("utilities.settings")
local navWheel = require("utilities.navWheel")
local activeCreature = require("utilities.activeCreature")
local pinchZoom = require("utilities.pinchZoom")

------------------------------------------------------------------------------------
-- VARIABLE DECLARATIONS
------------------------------------------------------------------------------------

-- DISPLAY GROUPS
	local group
	local captureGroup = display.newGroup()
	local creatureGroup = display.newGroup()
	creatureGroup.alpha = 0

-- DISPLAY OBJECTS
	local sheetInfo = require("images.play")
	local imageSheet = graphics.newImageSheet( "images/play.png", sheetInfo:getSheet() )
	local partsSheetInfo = require("images.parts")
	local partsImageSheet = graphics.newImageSheet( "images/parts.png", partsSheetInfo:getSheet() )
	local bg, whiteout, wheel, album, photo, camera, saveBW, saveColor, buildBG, dungeonBG, creature, bwCreature, newBackground

-- FUNCTIONS
	local wheelListener, openAlbum, closeAlbum, buttonListener, fromCamera, fromPhotos, bgListener, colorSnap, bwSnap, capture, CFLogo, website

-- SOUNDS
	local sounds = {
		albumOpen = audio.loadSound("audio/albumOpen.wav"),
		albumClose = audio.loadSound("audio/albumClose.wav"),
		albumButton = audio.loadSound("audio/albumButton.wav"),
		wheelSpin = audio.loadSound("audio/wheelSpin.wav"),
	}

-- OTHER
	

------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------

function wheelListener(event)
	audio.play(sounds.wheelSpin)
	if event.direction == "clockwise" then
		transition.to(dungeonBG, {x = screenRight + ((dungeonBG.width - screenWidth)*.5), time = 1800, onComplete = function()
			composer.gotoScene("scenes.dungeon")
		end})
	elseif event.direction == "counterclockwise" then
		transition.to(buildBG, {x = screenLeft - ((buildBG.width - screenWidth)*.5), time = 1800, onComplete = function()
			composer.gotoScene("scenes.build")
		end})
	end
end

function openAlbum()
	if album.x <= screenLeft - 220 then
		audio.play(sounds.albumClose)
		album:setSequence("open")
		album:play()
		transition.to(album, {x = screenLeft - 20, time = 400, transition = easing.inOutBack, onComplete = function()
				transition.to(camera, {alpha = 1, time = 200})
				transition.to(photo, {alpha = 1, time = 200})
				transition.to(saveBW, {alpha = 1, time = 200})
				transition.to(saveColor, {alpha = 1, time = 200})
		end})
	end
end

function closeAlbum()
	if album.x >= screenLeft - 20 then
		audio.play(sounds.albumOpen)
		transition.to(camera, {alpha = 0, time = 200})
		transition.to(photo, {alpha = 0, time = 200})
		transition.to(saveBW, {alpha = 0, time = 200})
		transition.to(saveColor, {alpha = 0, time = 200, onComplete = function()
			album:setSequence("close")
			album:play()
			transition.to(album, {x = screenLeft - 220, time = 400, transition = easing.inOutBack})
		end})
	end
end

function bgListener(event)
	if event.completed==true then
		display.remove(newBackground)
		newBackground = event.target
		newBackground.x, newBackground.y = centerX, centerY
		local scale = 1
		if newBackground.width < screenWidth then
			scale = screenWidth / newBackground.width
			newBackground.xScale, newBackground.yScale = scale, scale
		end
		if newBackground.contentHeight < screenHeight then
			scale = scale * (screenHeight/newBackground.contentHeight)
			newBackground.xScale, newBackground.yScale = scale, scale
		end
		captureGroup:insert(3, newBackground)
		closeAlbum()
	end
end

function fromCamera(event)
	media.capturePhoto({listener = bgListener})
	return true
end


function fromPhotos(event)
	local target = event.target
	media.selectPhoto({listener = bgListener, origin = target.contentBounds})
end

function capture()
	closeAlbum()
	local white = display.newRect(captureGroup, centerX, centerY, screenWidth, screenHeight)
	white:setFillColor(1, 1, 1)
	white.alpha = 0
	transition.to(white, {alpha = .6})
	local preview = display.capture(captureGroup, {saveToPhotoLibrary = true, isFullResolution = true})
	preview.x, preview.y = centerX, centerY
	preview.xScale, preview.yScale = .7, .7
	preview.rotation = math.random(-8,8)
	group:insert(preview)
	
	local function alertHandler( event )
		if "clicked" == event.action then
			transition.to(preview, {y = screenTop - centerY, alpha = 0, transition = easing.inOutBack, time = 800, onComplete = function() display.remove(preview) end})
			transition.to(white, {alpha = 0, onComplete = function() display.remove(white) end})
		end
	end
	
	website.isVisible = false
	bg.isVisible = true
	if newBackground~=nil then newBackground.isVisible = true end
	creature.isVisible = true
	bwCreature.isVisible = false
	
	native.showAlert( "Saved to Photo Library", "This photo has been saved to your device's photo library.", {"OK"}, alertHandler )
end

function colorSnap()
	bg.isVisible = true
	if newBackground~=nil then newBackground.isVisible = true end
	creature.isVisible = true
	bwCreature.isVisible = false
	website.isVisible = true
	capture()
end

function bwSnap()
	bg.isVisible = false
	if newBackground~=nil then newBackground.isVisible = false end
	creature.isVisible = false
	bwCreature.isVisible = true
	website.isVisible = true
	capture()
end

function buttonListener(event)
	local target = event.target
	audio.play(sounds.albumButton)
	
	if target == camera then
		fromCamera(event)
	elseif target == photo then
		fromPhotos(event)
	elseif target == saveColor then
		colorSnap()
	elseif target == saveBW then
		bwSnap()
	end
	return true
end

------------------------------------------------------------------------------------
-- CREATE SCENE
------------------------------------------------------------------------------------
function scene:create( event )
	group = self.view
	group:insert(captureGroup)
	
	-- create background
	whiteout = display.newRect(captureGroup, centerX, centerY, screenWidth, screenHeight)
	whiteout:setFillColor(1)
	
	bg = display.newRect(captureGroup, centerX, centerY, screenWidth, screenHeight)
	bg.fill = {
		type = "gradient",
		color1 = { 1, 17/255, 2/255, 1 },
		color2 = { 1, 237/255, 0, 1 },
		direction = "down"
	}
	
	bwCreature = activeCreature.loadBWStatic()
	bwCreature.x, bwCreature.y = 0, 0
	creatureGroup:insert(bwCreature)
	bwCreature.isVisible = false
	creature = activeCreature.loadStatic()
	creature.x, creature.y = 0, 0
	creatureGroup:insert(creature)
	
	creatureGroup.x, creatureGroup.y = centerX, centerY
	pinchZoom.add(creatureGroup)
	captureGroup:insert(creatureGroup)
	
	-- add logo
	CFLogo = display.newImage(captureGroup, imageSheet, sheetInfo:getFrameIndex("CFLogo"))
	CFLogo.anchorX, CFLogo.anchorY = 0, 1
	CFLogo.x, CFLogo.y = screenLeft, screenBottom
	CFLogo.alpha = 0
	
	-- add website address
	website = display.newText(captureGroup, "www.minor-distractions.com", screenRight, screenBottom, "HouseofTerror", 40)
	website:setFillColor(0)
	website.anchorX, website.anchorY = 1, 1
	website.isVisible = false
	
	-- create album
	local sequenceData = {
		{
			name="open",
			frames= {
				sheetInfo:getFrameIndex("album1"),
				sheetInfo:getFrameIndex("album2"),
				sheetInfo:getFrameIndex("album3"),
				sheetInfo:getFrameIndex("album4"),
				sheetInfo:getFrameIndex("album5"),
				sheetInfo:getFrameIndex("album6"),
			},
			loopCount = 1,
			time = 400,
		},
		{
			name="close",
			frames= {
				sheetInfo:getFrameIndex("album6"),
				sheetInfo:getFrameIndex("album5"),
				sheetInfo:getFrameIndex("album4"),
				sheetInfo:getFrameIndex("album3"),
				sheetInfo:getFrameIndex("album2"),
				sheetInfo:getFrameIndex("album1"),
			},
			loopCount = 1,
			time = 400,
		},
	}

	album = display.newSprite( imageSheet, sequenceData )
	album.anchorX, album.anchorY = 0, 0
	album.x, album.y = screenLeft - album.width, screenTop
	group:insert(album)
	album:setSequence("open")
	album:addEventListener("tap", openAlbum)
	
	-- create buttons
	camera = widget.newButton({
		sheet = imageSheet,
		defaultFrame = sheetInfo:getFrameIndex("camera1"),
		overFrame = sheetInfo:getFrameIndex("camera2"),
		onRelease = buttonListener,
	})
	camera.x, camera.y = screenLeft + 80, screenTop + 120
	group:insert(camera)
	camera.alpha = 0
	
	photo = widget.newButton({
		sheet = imageSheet,
		defaultFrame = sheetInfo:getFrameIndex("photo1"),
		overFrame = sheetInfo:getFrameIndex("photo2"),
		onRelease = buttonListener,
	})
	photo.x, photo.y = screenLeft + 200, screenTop + 120
	group:insert(photo)
	photo.alpha = 0
	
	saveColor = widget.newButton({
		sheet = imageSheet,
		defaultFrame = sheetInfo:getFrameIndex("saveColor1"),
		overFrame = sheetInfo:getFrameIndex("saveColor2"),
		onRelease = buttonListener,
	})
	saveColor.x, saveColor.y = screenLeft + 330, screenTop + 120
	group:insert(saveColor)
	saveColor.alpha = 0
	
	saveBW = widget.newButton({
		sheet = imageSheet,
		defaultFrame = sheetInfo:getFrameIndex("saveBW1"),
		overFrame = sheetInfo:getFrameIndex("saveBW2"),
		onRelease = buttonListener,
	})
	saveBW.x, saveBW.y = screenLeft + 450, screenTop + 120
	group:insert(saveBW)
	saveBW.alpha = 0
	
	-- adjacent scene backgrouds
	buildBG = display.newImage(group, "images/buildBG.jpg", true)
	buildBG.anchorX = 0
	buildBG.x, buildBG.y = screenRight, centerY
	
	dungeonBG = display.newImage(group, "images/dungeonBG.jpg", true)
	dungeonBG.anchorX = 1
	dungeonBG.x, dungeonBG.y = screenLeft, centerY
	
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
		transition.to(album, {x = screenLeft - 220, transition = easing.inOutBack})
		transition.to(creatureGroup, {alpha = 1})
		transition.to(CFLogo, {alpha = 1})
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