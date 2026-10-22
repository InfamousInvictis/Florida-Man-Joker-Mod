local DevilRave_atlas = {
    object_type = "Atlas", 
    key = "DevilRave_atlas", 
    path = "DevilRave.png", 
    px = 71, py = 95
}

local DevilRave = {
    object_type = "Joker",
    order = 23,
    key = "DevilRave",
    config = { extra = { xmult = 1.5 } },
    rarity = 3,
    atlas = 'DevilRave_atlas',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    attributes = { "animal" },
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.xmult,
            colours = { G.C.DARK_EDITION }
        } }
    end,
    in_pool = function(self, args)
        if G.jokers and G.jokers.cards then
            for _, card in ipairs(G.jokers.cards) do
                if card.edition and card.edition.key == "e_polychrome" then
                    return true
                end
            end
        end
        if G.playing_cards then
            for _, card in ipairs(G.playing_cards) do
                if card.edition and card.edition.key == "e_polychrome" then
                    return true
                end
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if context.other_joker then
            if context.other_joker.edition and context.other_joker.edition.key == "e_polychrome" then
                return {
                    xmult = card.ability.extra.xmult,
                }
            end
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card.edition and context.other_card.edition.key == "e_polychrome" then
                return {
                    xmult = card.ability.extra.xmult,
                }
            end
        end
    end
}

return { name = {"Jokers"}, items = {DevilRave_atlas, DevilRave} }
