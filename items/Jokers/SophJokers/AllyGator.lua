local AllyGator_atlas = {
    object_type = "Atlas", 
    key = "AllyGator_atlas", 
    path = "AllyGator.png", 
    px = 71, py = 95
}

local AllyGator = {
    object_type = "Joker",
    order = 27,
    key = "AllyGator",
    config = { extra = { chips = 30 } },
    rarity = 1,
    atlas = 'AllyGator_atlas',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    attributes = { "croc" },
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.chips,
            colours = { G.C.DARK_EDITION }
        } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker:has_attribute("croc") then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

return { name = {"Jokers"}, items = {AllyGator_atlas, AllyGator} }
