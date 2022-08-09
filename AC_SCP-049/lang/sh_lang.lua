AC_SCP49.lang = {
    // Potion Menu
    ["red_potion"] = "Red",
    ["green_potion"] = "Green",
    ["blue_potion"] = "Blue",
    ["yellow_potion"] = "Yellow",
    ["cyan_potion"] = "Cyan",
    ["pink_potion"] = "Pink",
    ["white_potion"] = "White",

    ["cure_title"] = "Cure mixer",
    ["cure_instructions"] = "Pick two potions to create a cure, different combinations create different effects",
    ["cure_bag_bind"] = "[%s + %s] Open cure bag",
    ["cure_name"] = "%s and %s Cure",
    ["start_mixing"] = "Mix Cure",
    ["is_mixing"] = "Mixing Cure",
    ["cure_limit"] = "You cannot carry any more cures",
    ["already_mixing"] = "You are already mixing a cure",
    ["done_mixing"] = "You have finished mixing the cure",
    ["none"] = "None",

    // Cure bag
    ["cure_bag"] = "Cure Bag",
    ["no_cures"] = "You have no cures",
    ["equipped_cure"] = "You equipped the %s",
    ["unequipped_cure"] = "You put away the %s",

    // Sound menu
    ["soundMenu.company"] = "Company",
    ["soundMenu.do_not_be_afraid"] = "Do not be afraid",
    ["soundMenu.greetings"] = "Greetings",
    ["soundMenu.hello"] = "Hello",
    ["soundMenu.the_cure"] = "I am the cure",
    ["soundMenu.not_well"] = "You are not well",
    ["soundMenu.breathing"] = "I can hear you breathing",
    ["soundMenu.i_know"] = "I know you are in here",
    ["soundMenu.get_to_work"] = "I need to get to work",
    ["soundMenu.sense_disease"] = "I sense the disease in you",
    ["soundMenu.not_trying"] = "I'm not trying to harm you",
    ["soundMenu.still"] = "Lay still",
    ["soundMenu.remove"] = "Let's get this",
    ["soundMenu.effective"] = "My cure is most effective",
    ["soundMenu.doctor"] = "You are not a doctor",
    ["soundMenu.victim"] = "Another victim of the disease",
    ["soundMenu.rosies"] = "Ringo Ringo Roses",
    ["soundMenu.resisting"] = "Stop resisting",
    ["soundMenu.found"] = "There you are",
    ["soundMenu.hide"] = "There's no need to hide",


    // Weapon HUD
    ["swep_hud_text"] = "[%s] Open cure mixer",
    ["swep_current_text"] = "Equipped Cure: %s",

    // Admin Menu
    ["frame_title"] = "SCP-049 Admin Menu",
    ["scp_settings_name"] = "SCP Settings",
    ["scp_settings_desc"] = "Change settings of SCP-049 and 049-2",
    ["general_settings_name"] = "General Settings",
    ["general_settings_desc"] = "Change settings such as commands, admin ranks, etc.",
    ["settings_apply"] = "Apply",
    ["settings_back"] = "Back",


    // SCP Admin Menu
    ["scp_immuneModels_name"] = "Immune Models",
    ["scp_immuneModels_desc"] = "Models that cannot be killed by SCP-049, spereate models with a space",
    ["scp_mixTime_name"] = "Mixing Time",
    ["scp_mixTime_desc"] = "Time it takes to mix a cure",
    ["scp_soundLevel_name"] = "Voiceline Volume",
    ["scp_soundLevel_desc"] = "The volume of SCP-049s voicelines",
    ["scp_scp049Job_name"] = "Job Name",
    ["scp_scp049Job_desc"] = "The Job Name of SCP-049",
    ["scp_cureLimit_name"] = "Cure Limit",
    ["scp_cureLimit_desc"] = "The number of cures SCP-049 can carry",
    ["scp_zombieModel_name"] = "SCP-049-2 Model",
    ["scp_zombieModel_desc"] = "The model used for 049-2",
    ["scp_zombieOutlineColor_name"] = "049-2 Outline Color",
    ["scp_zombieOutlineColor_desc"] = "The color used on the outlines of 049 and 049-2",
    ["scp_doorAutoClose_name"] = "Door Auto Close Time",
    ["scp_doorAutoClose_desc"] = "The time it takes for doors broken by 049-2, to automatically close",
    
    // General Admin Menu
    ["general_menuCommands_name"] = "Chat Commands",
    ["general_menuCommands_desc"] = "Chat commands to open the admin menu",
    ["general_adminRanks_name"] = "Admin Ranks",
    ["general_adminRanks_desc"] = "Ranks that can access and make changes to the config",

    ["changes_made_noti"] = "SCP-049 Config: Changes applied",

}

function AC_SCP49.getLang(phrase)
    if !phrase or !AC_SCP49.lang[phrase] then error("Phrase does not exist!") return "UNKOWN STRING" end
    return AC_SCP49.lang[phrase] 
end
