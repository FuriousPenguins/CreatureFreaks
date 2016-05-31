--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:917a4602f65a0d6f9534b81aa8d975f5:53a742e3716e69443dda7264dee630bf:5c3cfb09e5aa9ca6437657c571c026a6$
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
            y=406,
            width=128,
            height=100,

        },
        {
            -- album1
            x=1106,
            y=204,
            width=550,
            height=200,

        },
        {
            -- album2
            x=1106,
            y=2,
            width=550,
            height=200,

        },
        {
            -- album3
            x=554,
            y=204,
            width=550,
            height=200,

        },
        {
            -- album4
            x=554,
            y=2,
            width=550,
            height=200,

        },
        {
            -- album5
            x=2,
            y=204,
            width=550,
            height=200,

        },
        {
            -- album6
            x=2,
            y=2,
            width=550,
            height=200,

        },
        {
            -- camera1
            x=1758,
            y=234,
            width=98,
            height=114,

        },
        {
            -- camera2
            x=1858,
            y=118,
            width=98,
            height=114,

        },
        {
            -- photo1
            x=1758,
            y=118,
            width=98,
            height=114,

        },
        {
            -- photo2
            x=1658,
            y=350,
            width=98,
            height=114,

        },
        {
            -- saveBW1
            x=1658,
            y=234,
            width=98,
            height=114,

        },
        {
            -- saveBW2
            x=1658,
            y=118,
            width=98,
            height=114,

        },
        {
            -- saveColor1
            x=1858,
            y=2,
            width=98,
            height=114,

        },
        {
            -- saveColor2
            x=1758,
            y=2,
            width=98,
            height=114,

        },
        {
            -- x
            x=1658,
            y=2,
            width=98,
            height=114,

        },
    },
    
    sheetContentWidth = 2048,
    sheetContentHeight = 512
}

SheetInfo.frameIndex =
{

    ["CFLogo"] = 1,
    ["album1"] = 2,
    ["album2"] = 3,
    ["album3"] = 4,
    ["album4"] = 5,
    ["album5"] = 6,
    ["album6"] = 7,
    ["camera1"] = 8,
    ["camera2"] = 9,
    ["photo1"] = 10,
    ["photo2"] = 11,
    ["saveBW1"] = 12,
    ["saveBW2"] = 13,
    ["saveColor1"] = 14,
    ["saveColor2"] = 15,
    ["x"] = 16,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
