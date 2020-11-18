local frame = CreateFrame("Button", "DragFrame2", UIParent)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    -- The code below makes the frame visible, and is not necessary to enable dragging.
    frame:SetPoint("CENTER"); frame:SetWidth(64); frame:SetHeight(64);
local tex = frame:CreateTexture("ARTWORK");
    tex:SetAllPoints();
    --tex:SetHighlightTexture("Interface/Minimap/UI-Minimap-ZoomButton-Highlight")
    tex:SetTexture("Interface\\Icons\\Inv_misc_bone_skull_01")
    tex:SetMask("Interface/COMMON/Indicator-Yellow.png")
    tex:SetAlpha(0.5);

local button = CreateFrame("Button", "AuM", UIParent, "SecureActionButtonTemplate");
    button:SetPoint("CENTER", 50)
    button:SetSize(250, 50);
    button:SetMovable(true);
    button:EnableMouse(true);
    
    button:RegisterForDrag("LeftButton")
    button:SetScript("OnDragStart", frame.StartMoving)
    button:SetScript("OnDragStop", frame.StopMovingOrSizing)

    button:SetScript("OnMouseDown", function(self, btn)
        if btn == "RightButton" then
            button:Hide();
        end
    end)

local ntex = button:CreateTexture()
    ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
    ntex:SetTexCoord(0, 0.625, 0, 0.6875)
    ntex:SetAllPoints()	
button:SetNormalTexture(ntex)
button:Hide();
frame:SetScript("OnClick", function()
    Run()
end)

function Run()
    local timeSpanHour = 3;
    local timeSpanMin = 20;
    local baseDay = 12;

    local hour, minute = GetGameTime()
    local day = date("%d")
    local currentTimeInMin = (day*60*60) + (hour*60) + minute;
    local boss = 
    {
        [1]  = { ["name"] = "Skadi the Ruthless",           ["coorX"] = "57,8",     ["coorY"] = "56,1", ["day"] =  17, ["hour"] = 15, ["min"] = 30},
        [2]  = { ["name"] = "Ingvar the Plunderer",         ["coorX"] = "52,4",     ["coorY"] = "52,6", ["day"] =  17, ["hour"] = 15, ["min"] = 40},
        [3]  = { ["name"] = "Prince Keleseth",              ["coorX"] = "54,0",     ["coorY"] = "44,7", ["day"] =  17, ["hour"] = 15, ["min"] = 50},
        [4]  = { ["name"] = "The Black Knight",             ["coorX"] = "64,8",     ["coorY"] = "22,1", ["day"] =  17, ["hour"] = 16, ["min"] = 0},
        [5]  = { ["name"] = "Bronjahm",                     ["coorX"] = "70,7",     ["coorY"] = "38,4", ["day"] =  17, ["hour"] = 16, ["min"] = 10},
        [6]  = { ["name"] = "Scourgelord Tyrannus",         ["coorX"] = "47,2",     ["coorY"] = "66,1", ["day"] =  17, ["hour"] = 16, ["min"] = 20},
        [7]  = { ["name"] = "Forgemaster Garfrost",         ["coorX"] = "58,6",     ["coorY"] = "72,5", ["day"] =  17, ["hour"] = 16, ["min"] = 30},
        [8]  = { ["name"] = "Marwyn",                       ["coorX"] = "58,2",     ["coorY"] = "83,4", ["day"] =  17, ["hour"] = 16, ["min"] = 40},
        [9]  = { ["name"] = "Falric",                       ["coorX"] = "50,2",     ["coorY"] = "87,9", ["day"] =  17, ["hour"] = 16, ["min"] = 50},
        [10] = { ["name"] = "The Prophet Tharon'ja",        ["coorX"] = "80,1",     ["coorY"] = "61,2", ["day"] =  17, ["hour"] = 17, ["min"] = 0},
        [11] = { ["name"] = "Novos the Summoner",           ["coorX"] = "77,8",     ["coorY"] = "66,1", ["day"] =  17, ["hour"] = 17, ["min"] = 10},
        [12] = { ["name"] = "Trollgore",                    ["coorX"] = "58,3",     ["coorY"] = "39,4", ["day"] =  17, ["hour"] = 17, ["min"] = 20},
        [13] = { ["name"] = "Krik'thir the Gatewatcher",    ["coorX"] = "67,5",     ["coorY"] = "58,0", ["day"] =  17, ["hour"] = 17, ["min"] = 30},
        [14] = { ["name"] = "Prince Taldaram",              ["coorX"] = "29,6",     ["coorY"] = "62,2", ["day"] =  17, ["hour"] = 17, ["min"] = 40},
        [15] = { ["name"] = "Elder Nadox",                  ["coorX"] = "44,2",     ["coorY"] = "49,1", ["day"] =  17, ["hour"] = 17, ["min"] = 50},
        [16] = { ["name"] = "Noth the Plaguebringer",       ["coorX"] = "31,6",     ["coorY"] = "70,5", ["day"] =  17, ["hour"] = 18, ["min"] = 0},
        [17] = { ["name"] = "Patchwerk (in cave)",          ["coorX"] = "34,4",     ["coorY"] = "68,3", ["day"] =  17, ["hour"] = 18, ["min"] = 10},
        [18] = { ["name"] = "Blood Queen Lana'thel",        ["coorX"] = "49,7",     ["coorY"] = "32,7", ["day"] =  17, ["hour"] = 15, ["min"] = 0},
        [19] = { ["name"] = "Professor Putricide",          ["coorX"] = "57,1",     ["coorY"] = "30,3", ["day"] =  17, ["hour"] = 15, ["min"] = 10},
        [20] = { ["name"] = "Lady Deathwhisper",            ["coorX"] = "51,1",     ["coorY"] = "78,5", ["day"] =  17, ["hour"] = 15,  ["min"] = 20}
    };

    for id, item in pairs(boss) do
        local bossDay = item.day;
        local bossHour = item.hour;
        local bossMin = item.min;
        local found = false;

        local bossHourText = bossHour;
        local bossMinText = bossMin;
        for i = 1, 100 do
            if bossMin >= 60 then
                bossMin = bossMin - 60;
                bossHour = bossHour + 1;
            end
            if bossHour >= 24 then
                bossHour = bossHour - 24;
                bossDay = bossDay + 1;
            end
            bossHourText = bossHour;
            bossMinText = bossMin;
            if bossHour == 0 then
                bossHourText = "00"
            end
            if bossMin == 0 then
                bossMinText = "00"
            end
            bossTimeInMin = (bossDay*60*60) + (bossHour*60) + bossMin;
            if (bossTimeInMin - currentTimeInMin <= 10 and bossTimeInMin - currentTimeInMin >= 0) then
                local macroText = "/way "..item.coorX..", "..item.coorY.." "..item.name.." ( Nov "..bossDay.." "..bossHourText..":"..bossMinText.." )";
                button:SetAttribute("type", "macro");
                button:SetAttribute("macrotext", macroText);
                button:RegisterForClicks("LeftButtonUp");
                button:SetText(item.name.." ( Nov "..bossDay.." "..bossHourText..":"..bossMinText.." )");
                button:SetNormalFontObject("GameFontHighlight");
                button:Show()
            end
            if (bossTimeInMin - currentTimeInMin <= 200 and bossTimeInMin - currentTimeInMin >= 0 and (item.name == "Skadi the Ruthless" or item.name == "Bronjahm")) then
                print(item.name.." ( Nov "..bossDay.." "..bossHourText..":"..bossMinText.." )");
            end
            bossMin = bossMin + timeSpanMin;
            bossHour = bossHour + timeSpanHour;
        end
    end
end