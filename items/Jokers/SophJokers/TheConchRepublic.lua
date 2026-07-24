local TheConchRepublic_atlas = {
    object_type = "Atlas", 
    key = "the_conch_republic_atlas", 
    path = "TheConchRepublic.png", 
    px = 71, py = 95
}

local TheConchRepublic = {
    object_type = "Joker",
    order = 45,
    key = "TheConchRepublic",
    config = { extra = { mult = 0, mult_mod = 1, numerator = 1, denominator = 1982 } },
    rarity = 3,
    atlas = 'the_conch_republic_atlas',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
  
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator, 'flor_TheConchRepublic')
        return { vars = { 
            card.ability.extra.mult_mod,
            card.ability.extra.mult,
            numerator,
            denominator,
            colours = { G.C.DARK_EDITION }
        } }
    end,

    calculate = function(self, card, context)
        if context.discard and not context.blueprint and not context.other_card.debuff then
            if SMODS.pseudorandom_probability(card, 'flor_TheConchRepublic', card.ability.extra.numerator, card.ability.extra.denominator) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_secede_ex")
                }
            end
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "mult_mod",
                operation = "+",
                message_colour = G.C.RED,
                no_message = true
            })
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.FILTER,
                delay = 0.2
            }
        end
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult = card.ability.extra.mult,
            }
        end
    end
}

return { name = {"Jokers"}, items = {TheConchRepublic_atlas, TheConchRepublic} }
