local Sandcastle_atlas = {
    object_type = "Atlas", 
    key = "Sandcastle_atlas", 
    path = "Sandcastle.png", 
    px = 71, py = 95
}

local Sandcastle = {
    object_type = "Joker",
    order = 50,
    key = "Sandcastle",
    config = { extra = { xmult = 3, xmult_lose = 0.5, xmult_min = 1, xmult_max = 3, } },
    rarity = 2,
    atlas = 'Sandcastle_atlas',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.xmult,
            card.ability.extra.xmult_lose,
            card.ability.extra.xmult_min,
            colours = { G.C.DARK_EDITION }
        } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        elseif context.after and not context.blueprint then
            if (card.ability.extra.xmult - card.ability.extra.xmult_lose) > card.ability.extra.xmult_min then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_value = "xmult_lose",
                    operation = "-",
                    message_key = 'a_xmult_minus',
                    message_colour = G.C.RED
                })
            else
                card.ability.extra.xmult = card.ability.extra.xmult_max
                return {
                    message = localize("k_reset")
                }
            end
            return nil, true
        end
    end
}

return { name = {"Jokers"}, items = {Sandcastle_atlas, Sandcastle} }
