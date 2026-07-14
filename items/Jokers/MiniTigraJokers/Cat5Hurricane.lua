local Cat5Hurricane_atlas = {
    object_type = "Atlas", 
    key = "cat5_atlas", 
    path = "Category_5.png", 
    px = 71, py = 95
}

local Cat5Hurricane = {
    object_type = "Joker",
    order = 5,
    key = "Cat5Hurricane",
    config = { extra = { mult = 7 } },
    rarity = 2,
    atlas = 'cat5_atlas',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self, info_queue, card)
        return {vars = { 
            card.ability.extra.mult
        }}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.edition and context.other_card.edition.polychrome then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end

        if context.joker_main then
            local poly_jokers = 0
            for _, joker in ipairs(G.jokers.cards) do
                if joker.edition and joker.edition.polychrome and joker ~= card then
                    poly_jokers = poly_jokers + 1
                end
            end
            if poly_jokers > 0 then
                return {
                    mult_mod = card.ability.extra.mult * poly_jokers,
                    message = '+' .. (card.ability.extra.mult * poly_jokers) .. ' Mult',
                    card = card
                }
            end
        end
    end
}

return { name = {"Jokers"}, items = {Cat5Hurricane_atlas, Cat5Hurricane} }