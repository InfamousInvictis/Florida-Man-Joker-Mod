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
    config = { extra = { mult = 4, required_cards = 4 } },
    rarity = 1,
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
            card.ability.extra.mult, 
            card.ability.extra.required_cards,
            colours = { G.C.DARK_EDITION }
        } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if context.scoring_hand and #context.scoring_hand == card.ability.extra.required_cards then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = '+' .. card.ability.extra.mult .. ' Mult',
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end
}

return { name = {"Jokers"}, items = {SquareGrouper_atlas, SquareGrouper} }