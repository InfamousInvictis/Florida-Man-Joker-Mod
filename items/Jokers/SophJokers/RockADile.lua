local RockADile_atlas = {
    object_type = "Atlas", 
    key = "RockADile_atlas", 
    path = "RockADile.png", 
    px = 71, py = 95
}

local RockADile = {
    object_type = "Joker",
    order = 30,
    key = "RockADile",
    config = { extra = { xmult = 1, xmult_gain = 0.1 } },
    rarity = 1,
    atlas = 'RockADile_atlas',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    enhancement_gate = 'm_stone',
  
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.xmult,
            card.ability.extra.xmult_gain,
            colours = { G.C.DARK_EDITION }
        } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                xmult = card.ability.extra.xmult,
            }
        elseif context.before and not context.blueprint then
            for _, v in ipairs(context.full_hand) do
                if SMODS.has_enhancement(v, 'm_stone') then
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult",
                        scalar_value = "xmult_gain",
                        operation = "+",
                        message_colour = G.C.RED,
                    })
                    return nil, true
                end
            end
        elseif context.after and not context.blueprint then
            local stone_cards = {}
            for _, v in ipairs(context.full_hand) do
                if SMODS.has_enhancement(v, 'm_stone') then
                    table.insert(stone_cards, v)
                end
            end
            if #stone_cards > 0 then
                SMODS.destroy_cards(stone_cards)
            end
        end
    end
}

return { name = {"Jokers"}, items = {RockADile_atlas, RockADile} }
