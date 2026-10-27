local Jimbo_atlas = {
    object_type = "Atlas", 
    key = "Jimbo_atlas", 
    path = "Jimbo.png", 
    px = 71, py = 95
}

local Jimbo = {
    object_type = "Joker",
    order = 17,
    key = "Jimbo",
    config = { extra = { count = 0, count_max = 5, money = 5, hands = { } } },
    rarity = 1,
    atlas = 'Jimbo_atlas',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.count,
            card.ability.extra.count_max,
            card.ability.extra.money,
            colours = { G.C.DARK_EDITION }
        } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local hand = context.scoring_name

            if hand and not card.ability.extra.hands[hand] then
                card.ability.extra.count = card.ability.extra.count + 1
                card.ability.extra.hands[hand] = true

                if card.ability.extra.count >= card.ability.extra.count_max then
                    card.ability.extra.hands = {}
                end
                return {
                    message = card.ability.extra.count..'/'..card.ability.extra.count_max
                }
            end
        elseif context.joker_main and card.ability.extra.count >= card.ability.extra.count_max then
            return {
                dollars = card.ability.extra.money
            }
        elseif context.after and not context.blueprint and card.ability.extra.count >= card.ability.extra.count_max then
            card.ability.extra.count = 0
        end
    end
}

return { name = {"Jokers"}, items = {Jimbo_atlas, Jimbo} }
