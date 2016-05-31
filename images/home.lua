--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:9f5e088eb361dfe39fb5689aaad576b3:22bb25bb111b9d65d35871edabd3d53d:5dd131ccc94f5f1c1aa8da7f705ba89b$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- CFLogo
            x=2,
            y=2,
            width=694,
            height=532,

        },
        {
            -- minorDistractions
            x=698,
            y=2,
            width=276,
            height=91,

        },
    },
    
    sheetContentWidth = 1024,
    sheetContentHeight = 1024
}

SheetInfo.frameIndex =
{

    ["CFLogo"] = 1,
    ["minorDistractions"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
