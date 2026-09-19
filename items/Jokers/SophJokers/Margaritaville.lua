local Margaritaville_atlas = {
    object_type = "Atlas", 
    key = "Margaritaville_atlas", 
    path = "Margaritaville.png", 
    px = 71, py = 95
}

local Margaritaville = {
    object_type = "Joker",
    order = 48,
    key = "Margaritaville",
    config = { extra = { chips = 0, chips_gain = 7 } },
    rarity = 1,
    atlas = 'Margaritaville_atlas',
    pixel_size = { h = 95 / 1.7 },
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
  
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.chips,
            card.ability.extra.chips_gain,
            colours = { G.C.DARK_EDITION }
        } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chips = card.ability.extra.chips,
            }
        elseif context.using_consumeable and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chips_gain",
                operation = "+",
                message_colour = G.C.BLUE,
            })
            return nil, true
        elseif context.selling_card and context.card.ability.consumeable and not context.blueprint then
            card.ability.extra.chips = 0
            return {
                message = localize('k_reset'),
                colour = G.C.BLUE
            }
        end
    end
}

return { name = {"Jokers"}, items = {Margaritaville_atlas, Margaritaville} }
