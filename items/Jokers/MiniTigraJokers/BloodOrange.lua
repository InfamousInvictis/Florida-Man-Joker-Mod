local BloodOrange_atlas = {
    object_type = "Atlas", 
    key = "blood_orange_atlas", 
    path = "BloodOrange.png", 
    px = 71, py = 95
}

local BloodOrange = {
    object_type = "Joker",
    order = 36,
    key = "BloodOrange",
    config = { extra = { chance = 25 } },
    rarity = 1,
    atlas = 'blood_orange_atlas',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            (G.GAME and G.GAME.probabilities.normal or 1), 
            card.ability.extra.chance,
            colours = { G.C.DARK_EDITION }
        } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if G.SETTINGS.high_contrast and context.other_card:is_suit("Diamonds") then
                if context.other_card.seal ~= 'Red' then
                    
                    if pseudorandom('blood_orange') < G.GAME.probabilities.normal / card.ability.extra.chance then
                        local target_card = context.other_card
                        
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                target_card:set_seal('Red', true)
                                return true
                            end
                        }))
                        
                        return {
                            extra = { focus = context.other_card, message = 'Red Seal!', colour = G.C.RED },
                            card = card
                        }
                    end
                end
            end
        end
    end
}

return { name = {"Jokers"}, items = {BloodOrange_atlas, BloodOrange} }