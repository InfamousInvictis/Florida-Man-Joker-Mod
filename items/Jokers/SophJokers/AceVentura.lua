local AceVentura_atlas = {
    object_type = "Atlas", 
    key = "AceVentura_atlas", 
    path = "AceVentura.png", 
    px = 71, py = 95
}

local AceVentura = {
    object_type = "Joker",
    order = 43,
    key = "AceVentura",
    config = { extra = { xmult = 1.5 } },
    rarity = 2,
    atlas = 'AceVentura_atlas',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.xmult,
            colours = { G.C.DARK_EDITION }
        } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker:has_attribute("animal") then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

return { name = {"Jokers"}, items = {AceVentura_atlas, AceVentura} }
