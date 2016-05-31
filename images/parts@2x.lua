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
            x=1948,
            y=1716,
            width=552,
            height=742,

            sourceX = 4,
            sourceY = 2,
            sourceWidth = 564,
            sourceHeight = 745
        },
        {
            -- arm2
            x=1712,
            y=2882,
            width=436,
            height=720,

            sourceX = 4,
            sourceY = 2,
            sourceWidth = 440,
            sourceHeight = 733
        },
        {
            -- arm3
            x=2504,
            y=1618,
            width=328,
            height=544,

            sourceX = 4,
            sourceY = 0,
            sourceWidth = 336,
            sourceHeight = 544
        },
        {
            -- body1
            x=4,
            y=2916,
            width=522,
            height=932,

            sourceX = 16,
            sourceY = 12,
            sourceWidth = 556,
            sourceHeight = 959
        },
        {
            -- body2
            x=1106,
            y=2884,
            width=602,
            height=870,

            sourceX = 12,
            sourceY = 8,
            sourceWidth = 631,
            sourceHeight = 883
        },
        {
            -- body3
            x=4,
            y=1972,
            width=520,
            height=940,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 527,
            sourceHeight = 955
        },
        {
            -- ear1
            x=2114,
            y=1268,
            width=236,
            height=400,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 246,
            sourceHeight = 408
        },
        {
            -- ear2
            x=2736,
            y=1122,
            width=352,
            height=490,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 354,
            sourceHeight = 489
        },
        {
            -- ear3
            x=1216,
            y=3758,
            width=228,
            height=264,

            sourceX = 0,
            sourceY = 4,
            sourceWidth = 236,
            sourceHeight = 270
        },
        {
            -- eye1
            x=238,
            y=3852,
            width=238,
            height=178,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 242,
            sourceHeight = 182
        },
        {
            -- eye2
            x=3884,
            y=4,
            width=190,
            height=364,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 204,
            sourceHeight = 382
        },
        {
            -- eye3
            x=480,
            y=3852,
            width=184,
            height=178,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 186,
            sourceHeight = 184
        },
        {
            -- head1
            x=1482,
            y=2496,
            width=550,
            height=382,

            sourceX = 16,
            sourceY = 20,
            sourceWidth = 576,
            sourceHeight = 408
        },
        {
            -- head2
            x=2114,
            y=800,
            width=618,
            height=464,

            sourceX = 10,
            sourceY = 2,
            sourceWidth = 631,
            sourceHeight = 475
        },
        {
            -- head3
            x=1318,
            y=866,
            width=792,
            height=846,

            sourceX = 6,
            sourceY = 6,
            sourceWidth = 801,
            sourceHeight = 860
        },
        {
            -- horn1
            x=2354,
            y=1268,
            width=284,
            height=346,

            sourceX = 8,
            sourceY = 0,
            sourceWidth = 292,
            sourceHeight = 348
        },
        {
            -- horn2
            x=668,
            y=3772,
            width=186,
            height=296,

            sourceX = 4,
            sourceY = 2,
            sourceWidth = 190,
            sourceHeight = 299
        },
        {
            -- horn3
            x=4,
            y=3852,
            width=230,
            height=208,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 236,
            sourceHeight = 212
        },
        {
            -- leg1
            x=2152,
            y=2462,
            width=350,
            height=654,

            sourceX = 10,
            sourceY = 42,
            sourceWidth = 372,
            sourceHeight = 699
        },
        {
            -- leg2
            x=1030,
            y=866,
            width=284,
            height=850,

            sourceX = 4,
            sourceY = 8,
            sourceWidth = 291,
            sourceHeight = 861
        },
        {
            -- leg3
            x=1482,
            y=1716,
            width=462,
            height=776,

            sourceX = 12,
            sourceY = 4,
            sourceWidth = 475,
            sourceHeight = 792
        },
        {
            -- mouth1
            x=530,
            y=2884,
            width=572,
            height=884,

            sourceX = 26,
            sourceY = 14,
            sourceWidth = 597,
            sourceHeight = 926
        },
        {
            -- mouth2
            x=1448,
            y=3758,
            width=286,
            height=250,

            sourceX = 14,
            sourceY = 44,
            sourceWidth = 300,
            sourceHeight = 311
        },
        {
            -- mouth3
            x=858,
            y=3772,
            width=354,
            height=290,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 357,
            sourceHeight = 294
        },
        {
            -- tail1
            x=2738,
            y=4,
            width=1142,
            height=650,

            sourceX = 28,
            sourceY = 46,
            sourceWidth = 1200,
            sourceHeight = 714
        },
        {
            -- tail2
            x=2738,
            y=658,
            width=1130,
            height=460,

            sourceX = 0,
            sourceY = 10,
            sourceWidth = 1130,
            sourceHeight = 492
        },
        {
            -- tail3
            x=1660,
            y=4,
            width=1074,
            height=792,

            sourceX = 28,
            sourceY = 36,
            sourceWidth = 1116,
            sourceHeight = 857
        },
        {
            -- wing1
            x=4,
            y=4,
            width=1022,
            height=1964,

            sourceX = 30,
            sourceY = 2,
            sourceWidth = 1051,
            sourceHeight = 1967
        },
        {
            -- wing2
            x=1030,
            y=4,
            width=626,
            height=858,

            sourceX = 8,
            sourceY = 38,
            sourceWidth = 638,
            sourceHeight = 904
        },
        {
            -- wing3
            x=528,
            y=1972,
            width=950,
            height=908,

            sourceX = 10,
            sourceY = 2,
            sourceWidth = 965,
            sourceHeight = 912
        },
    },
    
    sheetContentWidth = 4096,
    sheetContentHeight = 4096
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
