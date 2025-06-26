local seagull_splat_atlas = {
	object_type = "Atlas", 
	key = "seagull_splat_atlas", 
	path = "seagull_splat.png", 
	px = 71, 
	py = 95
}
local seagull_splat_wild_atlas = {
	object_type = "Atlas", 
	key = "seagull_splat_wild_atlas", 
	path = "seagull_splat_wild.png", 
	px = 71, 
	py = 95
}

local seagull_splat = {
    object_type = "Joker",
    order = 8,
    key = "seagull_splat",
    config = { 

    },
    rarity = 2,
    atlas = 'seagull_splat_atlas',
	pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return {vars = {
            colours={G.C.DARK_EDITION}
        }}
    end,

    calculate = function(self,card,context)
        if context.cardarea == G.play and context.full_hand then
            for index, other_card in ipairs(context.full_hand) do
                if other_card.config.center ~= G.P_CENTERS["m_wild"] then
                    other_card:juice_up(0.3, 0.3)
                    other_card:set_ability("m_wild", nil, true)
                    other_card.ability.temp_seagull_splat = 0
                end              
            end
        end
        if context.end_of_round and context.cardarea == G.jokers then
            update_flor_seagull_splat()
        end
    end
}
return { name = {"Jokers"}, items = {seagull_splat_atlas, seagull_splat_wild_atlas, seagull_splat} }