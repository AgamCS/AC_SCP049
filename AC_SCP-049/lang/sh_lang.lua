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
    ["swep_current_text"] = "Equipped Cure: %s"

    
}

function AC_SCP49.getLang(phrase)
    if !phrase or !AC_SCP49.lang[phrase] then error("Phrase does not exist!") return "UNKOWN STRING" end
    return AC_SCP49.lang[phrase] 
end
