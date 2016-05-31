local settings = {}
local json = require("json")

------------------------------------------------------------------------------------
-- DEFINE DEFAULT SETTINGS
------------------------------------------------------------------------------------
local function setDefaults()
	-- define default key/value pairs
	settings.creatures = {}
	settings.soundOn = true
	
	-- save those settings!
	settings.save()
end

------------------------------------------------------------------------------------
-- SAVE SETTINGS FUNCTION
------------------------------------------------------------------------------------
function settings.save()
	local tempTable = {}
	for k,v in pairs(settings) do
		if k~="save" and k~="load" then
			tempTable[k] = v
		end
	end
	
	local path = system.pathForFile( "settings.json", system.DocumentsDirectory )
	local settingsJSON = json.encode(tempTable)
	
	local settingsFile = io.open( path, "w" )
	settingsFile:write( settingsJSON )
	io.close( settingsFile )
	tempTable = nil
	if system.getInfo("platformName") == "iPhone OS" then
		local results, errStr = native.setSync("settings.json", {iCloudBackup = false})
	end
end

------------------------------------------------------------------------------------
-- LOAD SETTINGS FUNCTION
------------------------------------------------------------------------------------
function settings.load()
	local path = system.pathForFile( "settings.json", system.DocumentsDirectory )
	local settingsFile, errStr = io.open( path, "r" )

	if settingsFile and system.getInfo("environment")~="simulator" then
		-- read settings from save data
		local settingsJSON = settingsFile:read("*a")
		local settingsLua = json.decode(settingsJSON)
		io.close(settingsFile)

		for k,v in pairs(settingsLua) do
			settings[k] = v
		end
	else
		setDefaults()
	end
end

return settings