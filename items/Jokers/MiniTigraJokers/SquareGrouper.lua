local SquareGrouper_atlas = {
    object_type = "Atlas", 
    key = "square_grouper_atlas", 
    path = "SquareGrouper.png", 
    px = 71, py = 95
}

local SquareGrouper = {
    object_type = "Joker",
    order = 42,
    key = "SquareGrouper",
    config = { extra = { mult = 0, mult_gain = 4, required_cards = 4 } },
    rarity = 2,
    atlas = 'square_grouper_atlas',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.mult_gain,
            card.ability.extra.required_cards,
            card.ability.extra.mult,
            colours = { G.C.DARK_EDITION }
        } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if context.full_hand and #context.full_hand == card.ability.extra.required_cards then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = 'Upgraded!',
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult .. ' Mult',
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

return { name = {"Jokers"}, items = {SquareGrouper_atlas, SquareGrouper} }