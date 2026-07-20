local Cat5Hurricane_atlas = {
    object_type = "Atlas", 
    key = "cat5_atlas", 
    path = "Category_5.png", 
    px = 71, py = 95
}

local Cat5Hurricane = {
    object_type = "Joker",
    order = 46,
    key = "Cat5Hurricane",
    config = { extra = { x_mult = 1.0, x_mult_gain = 0.5 } },
    rarity = 3,
    atlas = 'cat5_atlas',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.x_mult_gain,
            card.ability.extra.x_mult,
            colours = { G.C.DARK_EDITION }
        } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if context.poker_hands and (next(context.poker_hands['Full House']) or next(context.poker_hands['Flush House'])) then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
                return {
                    message = 'Upgraded!',
                    colour = G.C.MULT,
                    card = card
                }
            end
        end

        if context.joker_main and card.ability.extra.x_mult > 1.0 then
            return {
                Xmult_mod = card.ability.extra.x_mult,
                message = 'X' .. card.ability.extra.x_mult .. ' Mult!',
                card = card
            }
        end

        if context.destroying_card and not context.blueprint then
            if context.poker_hands and (next(context.poker_hands['Full House']) or next(context.poker_hands['Flush House'])) then
                return true 
            end
        end
    end
}

return { name = {"Jokers"}, items = {Cat5Hurricane_atlas, Cat5Hurricane} }