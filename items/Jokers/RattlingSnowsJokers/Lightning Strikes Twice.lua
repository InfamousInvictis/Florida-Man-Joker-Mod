local lightning_strikes_twice_atlas = {
	object_type = "Atlas", 
	key = "lightning_strikes_twice_atlas", 
	path = "lightning_strikes_twice.png", 
	px = 71, 
	py = 95
}

local lightning_strikes_twice = {
    object_type = "Joker",
    order = 18,
    key = "lightning_strikes_twice",
    config = { 
    
    },
    rarity = 2,
    atlas = 'lightning_strikes_twice_atlas',
	pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue + 1] = G.P_CENTERS.red_seal
        return {vars = {
            colours={G.C.DARK_EDITION}
        }}
    end,

    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card and context.other_card.seal == 'Red' then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = context.other_card 
                }
            end
        end
    end
}
return { name = {"Jokers"}, items = {lightning_strikes_twice_atlas, lightning_strikes_twice} }