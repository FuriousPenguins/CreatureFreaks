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
            x=4,
            y=4,
            width=1388,
            height=1064,

        },
        {
            -- minorDistractions
            x=1396,
            y=4,
            width=552,
            height=182,

        },
    },
    
    sheetContentWidth = 2048,
    sheetContentHeight = 2048
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
