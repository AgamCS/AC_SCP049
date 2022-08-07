// 28 unique combos

AC_SCP49.cures = {
    ["redred"] = {
        color = Color(255, 0, 0),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("red_potion"), AC_SCP49.getLang("red_potion")),
        class = "redred",
    },

    ["redgreen"] = {
        color = Color(158, 161, 5),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("red_potion"), AC_SCP49.getLang("green_potion")),
        class = "redgreen",
    },

    ["redblue"] = {
        color = Color(159, 0, 184),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(240) ply:SetMaxHealth(240)  ply:SetWalkSpeed(350) ply:SetRunSpeed(550) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("red_potion"), AC_SCP49.getLang("blue_potion")),
        class = "redblue",
    },


    ["redyellow"] = {
        color = Color(255, 94, 0),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) ply:SetColor(Color(255, 94, 0)) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("red_potion"), AC_SCP49.getLang("yellow_potion")),
        class = "redyellow",
    },

    ["redcyan"] = {
        color = Color(155, 155, 155),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("red_potion"), AC_SCP49.getLang("cyan_potion")),
        class = "redcyan",
    },

    ["redpink"] = {
        color = Color(237, 41, 255),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("red_potion"), AC_SCP49.getLang("pink_potion")),
        class = "redpink",
    },

    ["redwhite"] = {
        color = Color(255, 88, 88),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("red_potion"), AC_SCP49.getLang("white_potion")),
        class = "redwhite",
    },

    ["greengreen"] = {
        color = Color(0, 255, 0),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("green_potion"), AC_SCP49.getLang("green_potion")),
        class = "greengreen",
    },

    ["greenblue"] = {
        color = Color(0, 143, 143),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("green_potion"), AC_SCP49.getLang("blue_potion")),
        class = "greenblue",
    },

    ["greenyellow"] = {
        color = Color(154, 205, 50),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("green_potion"), AC_SCP49.getLang("yellow_potion")),
        class = "greenyellow",
    },

    ["greencyan"] = {
        color = Color(27, 248, 154),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("green_potion"), AC_SCP49.getLang("cyan_potion")),
        class = "greencyan",
    },

    ["greenpink"] = {
        color = Color(213, 96, 153),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("green_potion"), AC_SCP49.getLang("pink_potion")),
        class = "greenpink",
    },

    ["greenwhite"] = {
        color = Color(130, 255, 130),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("green_potion"), AC_SCP49.getLang("white_potion")),
        class = "greenwhite",
    },

    ["blueblue"] = {
        color = Color(0, 0, 255),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("blue_potion"), AC_SCP49.getLang("blue_potion")),
        class = "blueblue",
    },

    ["blueyellow"] = {
        color = Color(116, 118, 197),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("blue_potion"), AC_SCP49.getLang("yellow_potion")),
        class = "blueyellow"
    },

    ["bluecyan"] = {
        color = Color(0, 109, 252),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("blue_potion"), AC_SCP49.getLang("cyan_potion")),
        class = "bluecyan",
    },

    ["bluepink"] = {
        color = Color(96, 26, 255),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("blue_potion"), AC_SCP49.getLang("pink_potion")),
        class = "bluepink",
    },

    ["bluewhite"] = {
        color = Color(72, 72, 255),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("blue_potion"), AC_SCP49.getLang("white_potion")),
        class = "bluewhite",
    },

    ["yellowyellow"] = {
        color = Color(255, 255, 0),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) print(ply:DebugInfo()) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("yellow_potion"), AC_SCP49.getLang("yellow_potion")),
        class = "yellowyellow",
    },

    ["yellowcyan"] = {
        color = Color(183, 230, 51),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("yellow_potion"), AC_SCP49.getLang("cyan_potion")),
        class = "yellowcyan",
    },

    ["yellowpink"] = {
        color = Color(217, 145, 102),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("yellow_potion"), AC_SCP49.getLang("pink_potion")),
        class = "yellowpink",
    },

    ["yellowwhite"] = {
        color = Color(255, 255, 137),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("yellow_potion"), AC_SCP49.getLang("white_potion")),
        class = "yellowwhite",
    },

    ["cyancyan"] = {
        color = Color(0, 255, 255),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("cyan_potion"), AC_SCP49.getLang("cyan_potion")),
        class = "yellowwhite",
    },

    ["cyanpink"] = {
        color = Color(144, 102, 207),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("cyan_potion"), AC_SCP49.getLang("pink_potion")),
        class = "cyanpink",
    },

    ["cyanwhite"] = {
        color = Color(176, 255, 255),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("cyan_potion"), AC_SCP49.getLang("pink_potion")),
        class = "cyanwhite",
    },

    ["pinkpink"] = {
        color = Color(255, 0, 255),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("pink_potion"), AC_SCP49.getLang("pink_potion")),
        class = "pinkpink",
    },

    ["pinkwhite"] = {
        color = Color(255, 123, 255),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("pink_potion"), AC_SCP49.getLang("white_potion")),
        class = "pinkwhite",
    },

    ["whitewhite"] = {
        color = Color(255, 255, 255),
        model = AC_SCP49.config.cureModel,
        effect = function(ply) ply:SetHealth(200) ply:SetMaxHealth(200) end,
        name = string.format(AC_SCP49.getLang("cure_name"), AC_SCP49.getLang("white_potion"), AC_SCP49.getLang("white_potion")),
        class = "whitewhite"
    },

}

function AC_SCP49.getCure(combo)
    if !combo || !AC_SCP49.cures[combo] then return end
    return AC_SCP49.cures[combo]
end

function AC_SCP49.startCureMix(ply, cureType)
    if !cureType || !cures[cureType] then return end
    local cure = AC_SCP49.cures[cureType]
    if SERVER && !IsValid(ply) then return end
end

if SERVER then
    function AC_SCP49.applyCure(ply)

    end
end

