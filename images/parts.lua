--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:1d1a56b99d473d6d7808ce6ad70589ef:0c19212817da18ebebfdf2ca8ef31dfc:af1df6315cbeded8916c4a114733cd6a$
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
            -- arm1
            x=974,
            y=858,
            width=276,
            height=371,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 282,
            sourceHeight = 373
        },
        {
            -- arm2
            x=856,
            y=1441,
            width=218,
            height=360,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 220,
            sourceHeight = 367
        },
        {
            -- arm3
            x=1252,
            y=809,
            width=164,
            height=272,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 168,
            sourceHeight = 272
        },
        {
            -- body1
            x=2,
            y=1458,
            width=261,
            height=466,

            sourceX = 8,
            sourceY = 6,
            sourceWidth = 278,
            sourceHeight = 480
        },
        {
            -- body2
            x=553,
            y=1442,
            width=301,
            height=435,

            sourceX = 6,
            sourceY = 4,
            sourceWidth = 316,
            sourceHeight = 442
        },
        {
            -- body3
            x=2,
            y=986,
            width=260,
            height=470,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 264,
            sourceHeight = 478
        },
        {
            -- ear1
            x=1057,
            y=634,
            width=118,
            height=200,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 123,
            sourceHeight = 204
        },
        {
            -- ear2
            x=1368,
            y=561,
            width=176,
            height=245,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 177,
            sourceHeight = 245
        },
        {
            -- ear3
            x=608,
            y=1879,
            width=114,
            height=132,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 118,
            sourceHeight = 135
        },
        {
            -- eye1
            x=119,
            y=1926,
            width=119,
            height=89,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 121,
            sourceHeight = 91
        },
        {
            -- eye2
            x=1942,
            y=2,
            width=95,
            height=182,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 102,
            sourceHeight = 191
        },
        {
            -- eye3
            x=240,
            y=1926,
            width=92,
            height=89,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 93,
            sourceHeight = 92
        },
        {
            -- head1
            x=741,
            y=1248,
            width=275,
            height=191,

            sourceX = 8,
            sourceY = 10,
            sourceWidth = 288,
            sourceHeight = 204
        },
        {
            -- head2
            x=1057,
            y=400,
            width=309,
            height=232,

            sourceX = 5,
            sourceY = 1,
            sourceWidth = 316,
            sourceHeight = 238
        },
        {
            -- head3
            x=659,
            y=433,
            width=396,
            height=423,

            sourceX = 3,
            sourceY = 3,
            sourceWidth = 401,
            sourceHeight = 430
        },
        {
            -- horn1
            x=1177,
            y=634,
            width=142,
            height=173,

            sourceX = 4,
            sourceY = 0,
            sourceWidth = 146,
            sourceHeight = 174
        },
        {
            -- horn2
            x=334,
            y=1886,
            width=93,
            height=148,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 95,
            sourceHeight = 150
        },
        {
            -- horn3
            x=2,
            y=1926,
            width=115,
            height=104,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 118,
            sourceHeight = 106
        },
        {
            -- leg1
            x=1076,
            y=1231,
            width=175,
            height=327,

            sourceX = 5,
            sourceY = 21,
            sourceWidth = 186,
            sourceHeight = 350
        },
        {
            -- leg2
            x=515,
            y=433,
            width=142,
            height=425,

            sourceX = 2,
            sourceY = 4,
            sourceWidth = 146,
            sourceHeight = 431
        },
        {
            -- leg3
            x=741,
            y=858,
            width=231,
            height=388,

            sourceX = 6,
            sourceY = 2,
            sourceWidth = 238,
            sourceHeight = 396
        },
        {
            -- mouth1
            x=265,
            y=1442,
            width=286,
            height=442,

            sourceX = 13,
            sourceY = 7,
            sourceWidth = 299,
            sourceHeight = 463
        },
        {
            -- mouth2
            x=724,
            y=1879,
            width=143,
            height=125,

            sourceX = 7,
            sourceY = 22,
            sourceWidth = 150,
            sourceHeight = 156
        },
        {
            -- mouth3
            x=429,
            y=1886,
            width=177,
            height=145,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 179,
            sourceHeight = 147
        },
        {
            -- tail1
            x=1369,
            y=2,
            width=571,
            height=325,

            sourceX = 14,
            sourceY = 23,
            sourceWidth = 600,
            sourceHeight = 357
        },
        {
            -- tail2
            x=1369,
            y=329,
            width=565,
            height=230,

            sourceX = 0,
            sourceY = 5,
            sourceWidth = 565,
            sourceHeight = 246
        },
        {
            -- tail3
            x=830,
            y=2,
            width=537,
            height=396,

            sourceX = 14,
            sourceY = 18,
            sourceWidth = 558,
            sourceHeight = 429
        },
        {
            -- wing1
            x=2,
            y=2,
            width=511,
            height=982,

            sourceX = 15,
            sourceY = 1,
            sourceWidth = 526,
            sourceHeight = 984
        },
        {
            -- wing2
            x=515,
            y=2,
            width=313,
            height=429,

            sourceX = 4,
            sourceY = 19,
            sourceWidth = 319,
            sourceHeight = 452
        },
        {
            -- wing3
            x=264,
            y=986,
            width=475,
            height=454,

            sourceX = 5,
            sourceY = 1,
            sourceWidth = 483,
            sourceHeight = 456
        },
    },
    
    sheetContentWidth = 2048,
    sheetContentHeight = 2048
}

SheetInfo.frameIndex =
{

    ["arm1"] = 1,
    ["arm2"] = 2,
    ["arm3"] = 3,
    ["body1"] = 4,
    ["body2"] = 5,
    ["body3"] = 6,
    ["ear1"] = 7,
    ["ear2"] = 8,
    ["ear3"] = 9,
    ["eye1"] = 10,
    ["eye2"] = 11,
    ["eye3"] = 12,
    ["head1"] = 13,
    ["head2"] = 14,
    ["head3"] = 15,
    ["horn1"] = 16,
    ["horn2"] = 17,
    ["horn3"] = 18,
    ["leg1"] = 19,
    ["leg2"] = 20,
    ["leg3"] = 21,
    ["mouth1"] = 22,
    ["mouth2"] = 23,
    ["mouth3"] = 24,
    ["tail1"] = 25,
    ["tail2"] = 26,
    ["tail3"] = 27,
    ["wing1"] = 28,
    ["wing2"] = 29,
    ["wing3"] = 30,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
