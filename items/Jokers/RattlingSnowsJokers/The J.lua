local the_j_atlas = {
	object_type = "Atlas", 
	key = "the_j_atlas", 
	path = "the_j.png", 
	px = 71, 
	py = 95
}

local the_j = {
    object_type = "Joker",
    order = 10,
    key = "the_j",
    config = { 
        extra = {
            rounds = 2,
        }
    },
    rarity = 2,
    atlas = 'the_j_atlas',
	pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
        return {vars = {
            card.ability.extra.rounds,
            colours={G.C.DARK_EDITION}
        }}
    end,

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and context.other_card then
            if context.other_card.config.center == G.P_CENTERS.c_base and not context.other_card.ability.flor_disabled_for then
                context.other_card:juice_up(0.3, 0.3)
                context.other_card.ability.flor_disabled_for = {rounds = card.ability.extra.rounds+2, effect = "enhance", lvl = nil}
            end              
        end
    end
}
local ease_roundref = ease_round
function ease_round(mod)
    if mod ~= 0 then
        if G.playing_cards then
            for index, other_card in ipairs(G.playing_cards) do
                if other_card.ability.flor_disabled_for and other_card.ability.flor_disabled_for.rounds > 0 then
                    other_card.ability.flor_disabled_for.rounds = other_card.ability.flor_disabled_for.rounds - 1
                end
            end
            for index, other_card in ipairs(G.playing_cards) do      
                if other_card.ability.flor_disabled_for and other_card.ability.flor_disabled_for.rounds == 0 then
                    if other_card.ability.flor_disabled_for.effect == "enhance" then
                        local valid_enhancements = get_current_pool("Enhanced")
                        local _enhancement = pseudorandom_element(valid_enhancements, pseudoseed('the_j'..G.GAME.round_resets.ante))
                        other_card:set_ability(G.P_CENTERS[_enhancement], nil, true)
                    end
                    other_card.ability.flor_disabled_for = nil
                end
            end
        end
    end
    
    local ref = ease_roundref(mod)
    return ref
end
return { name = {"Jokers"}, items = {the_j_atlas, the_j} }