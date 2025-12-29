Config = {}

-- Loot settings
Config.LootTime = 5000 -- Time in ms to loot (5 seconds)
Config.LootCooldown = 3600000 -- Cooldown in ms before prop can be looted again (60 minutes)

-- Animation settings (Find more here: https://github.com/femga/rdr3_discoveries/blob/master/animations/ingameanims/ingameanims_list.lua)

Config.Animation = {
    dict = "script_common@other@unapproved",
    anim = "medic_kneel_enter",
    flag = 0 -- 1 = repeat, 0 = normal
}

-- Prop Config
-- Best to use the following site and resource to gather prop info:
-- https://redlookup.com/objects/?p=1&s=-1870850622&at=-1870850622
-- https://github.com/Blaze-Scripts/bs-entityinfo

Config.LootableProps = {
    -- Teir 1 Loot
    {model = `p_cratestack01x`, category = "teir1"},
	
	{model = `p_debris01x`, category = "teir2"},
	
	{model = `p_barrel06x`, category = "teir3"},

}

-- Loot tables by category
Config.LootTables = {
    teir1 = {
        {item = "bread", min = 1, max = 2, chance = 100}, -- 100% chance, 50 = 50%, 30 = 30% and so on....
        {item = "water", min = 1, max = 2, chance = 100}, -- 100% chance, 50 = 50%, 30 = 30% and so on....
    },
	
	teir2 = {
        {item = "bread", min = 3, max = 4, chance = 100},
        {item = "water", min = 3, max = 4, chance = 100},
    },
	
	teir3 = {
        {item = "bread", min = 6, max = 8, chance = 100},
        {item = "water", min = 6, max = 8, chance = 100},
    },

}
