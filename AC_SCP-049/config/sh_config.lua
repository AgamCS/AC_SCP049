if !AC_SCP49 then return end
AC_SCP49.config = AC_SCP49.config or {}

// Commands to open the admin menu
AC_SCP49.config.adminMenuCommands = {
    ["/cures"] = true,
    ["!cures"] = true,
}

// Models that cannot be killed by
AC_SCP49.config.immuneModels = {
    ["models/breen.mdl"] = true,
}

// Time in seconds it takes to mix a cure
AC_SCP49.config.mixTime = 8

// Sound settings
AC_SCP49.config.soundMenu = {
    [1] = {
        text = AC_SCP49.getLang("soundMenu.company"),
        soundFile = "049/DetectedInChamber.wav",
    },

    [2] = {
        text = AC_SCP49.getLang("soundMenu.do_not_be_afraid"),
        soundFile = "049/Spotted4.wav",
    },

    [3] = {
        text = AC_SCP49.getLang("soundMenu.greetings"),
        soundFile = "049/Spotted7.wav",
    },

    [4] = {
        text = AC_SCP49.getLang("soundMenu.hello"),
        soundFile = "049/Spotted6.wav",
    },

    [5] = {
        text = AC_SCP49.getLang("soundMenu.the_cure"),
        soundFile = "049/Spotted3.wav",
    },

    [6] = {
        text = AC_SCP49.getLang("soundMenu.not_well"),
        soundFile = "049/Searching4.wav",
    },

    [7] = {
        text = AC_SCP49.getLang("soundMenu.breathing"),
        soundFile = "049/Searching3.wav",
    },

    [8] = {
        text = AC_SCP49.getLang("soundMenu.i_know"),
        soundFile = "049/Searching1.wav",
    },

    [9] = {
        text = AC_SCP49.getLang("soundMenu.get_to_work"),
        soundFile = "049/Room2SL2.wav",
    },

    [10] = {
        text = AC_SCP49.getLang("soundMenu.sense_disease"),
        soundFile = "049/Searching6.wav",
    },
    

    [11] = {
        text = AC_SCP49.getLang("soundMenu.not_trying"),
        soundFile = "049/Searching5.wav",
    },

    [12] = {
        text = AC_SCP49.getLang("soundMenu.still"),
        soundFile = "049/Kidnap1.wav",
    },

    [13] = {
        text = AC_SCP49.getLang("soundMenu.remove"),
        soundFile = "049/TakeOffHazmat.wav",
    },

    [14] = {
        text = AC_SCP49.getLang("soundMenu.effective"),
        soundFile = "049/Kidnap2.wav",
    },

    [15] = {
        text = AC_SCP49.getLang("soundMenu.doctor"),
        soundFile = "049/Spotted2.wav",
    },

    [16] = {
        text = AC_SCP49.getLang("soundMenu.victim"),
        soundFile = "049/Spotted1.wav",
    },

    [17] = {
        text = AC_SCP49.getLang("soundMenu.rosies"),
        soundFile = "049/Searching7.wav",
    },

    [18] = {
        text = AC_SCP49.getLang("soundMenu.resisting"),
        soundFile = "049/714Equipped.wav",
    },

    [19] = {
        text = AC_SCP49.getLang("soundMenu.found"),
        soundFile = "049/Spotted5.wav",
    },

    [20] = {
        text = AC_SCP49.getLang("soundMenu.hide"),
        soundFile = "049/Searching2.wav",
    },

}

// Volume of SCP-049 voice lines
AC_SCP49.config.soundLevel = 100

// Ingredient Model
AC_SCP49.config.ingredientModel = "models/scp049/flask/flask.mdl"

// Cure Model 
AC_SCP49.config.cureModel = "models/scp049/graduatedcylinder/cylinder.mdl"

// The name of the SCP 049 job
AC_SCP49.config.scp049Job = "SCP 049"

// Max number of cures the player can carry
AC_SCP49.config.cureLimit = 1

// The model used for 049-2 instances
AC_SCP49.config.zombieModel = "models/player/zombie_classic.mdl"

// Ingredients for cures
AC_SCP49.config.ingredients = {
    ["red"] = {
        color = Color(255, 0, 0),
        model = AC_SCP49.config.ingredientModel,
        name = AC_SCP49.getLang("red_potion"),
    },

    ["green"] = {
        color = Color(0, 255, 0),
        model = AC_SCP49.config.ingredientModel,
        name = AC_SCP49.getLang("green_potion"),
    },

    ["blue"] = {
        color = Color(0, 0, 255),
        model = AC_SCP49.config.ingredientModel,
        name = AC_SCP49.getLang("blue_potion"),
    },

    ["yellow"] = {
        color = Color(255, 255, 0),
        model = AC_SCP49.config.ingredientModel,
        name = AC_SCP49.getLang("yellow_potion"),
    },

    ["cyan"] = {
        color = Color(0, 255, 255),
        model = AC_SCP49.config.ingredientModel,
        name = AC_SCP49.getLang("cyan_potion"),
    },

    ["pink"] = {
        color = Color(255, 0, 255),
        model = AC_SCP49.config.ingredientModel,
        name = AC_SCP49.getLang("pink_potion"),
    },

    ["white"] = {
        color = Color(255, 255, 255),
        model = AC_SCP49.config.ingredientModel,
        name = AC_SCP49.getLang("white_potion"),
    },
}


function AC_SCP49.getIngredient(name)
    if !name or !AC_SCP49.config.ingredients[name] then return end
    return AC_SCP49.config.ingredients[name]
end

function AC_SCP49.getIngredientName(name)
    if !name or !AC_SCP49.config.ingredients[name] then return AC_SCP49.getLang("none") end
    return AC_SCP49.config.ingredients[name].name
end

// Font settings
if CLIENT then
    surface.CreateFont("AC_SCP049.Font", {
        font = "Roboto",
        weight = 10,
        size = ScreenScale(8),
    })

    surface.CreateFont("AC_SCP049.FontScale12", {
        font = "Roboto",
        weight = 10,
        size = ScreenScale(12),
    })

    surface.CreateFont("AC_SCP049.Symbol", {
        font = "Roboto",
        weight = 10,
        size = ScreenScale(60),
    })
end
