local PolyTheParrot_atlas = {
	object_type = "Atlas", 
	key = "PolyTheParrot", 
	path = "PolyTheParrot.png", 
	px = 71, 
	py = 95
}

local PolyTheParrot = {
    object_type = "Joker",
    order = 5,
    key = "PolyTheParrot",
    config = { 
        extra = {
            mult = 7
        }
    },
    rarity = 2,
    atlas = 'PolyTheParrot',
	pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
        local poly_count = 0
        if G.jokers then
            for _, j in ipairs(G.jokers.cards) do
                if j.edition and j.edition.polychrome then poly_count = poly_count + 1 end
            end
        end
        return {
            vars = { card.ability.extra.mult, (card.ability.extra.mult * poly_count) },
            main_col = G.C.DARK_EDITION
        }
    end,

    calculate = function(self,card,context)
        if context.joker_main then

            local poly_count = 0

            for _, joker in ipairs(G.jokers.cards) do
                if joker.edition and joker.edition.polychrome then
                    poly_count = poly_count + 1
                end
            end

            if context.scoring_hand then
                for _, scoringcard in ipairs(context.scoring_hand) do
                    if scoringcard.edition and scoringcard.edition.polychrome then
                        poly_count = poly_count + 1
                    end
                end
            end

            if poly_count > 0 then
                local total_mult = card.ability.extra.mult * poly_count
                return {
                    mult_mod = total_mult,
                    message = '+' .. total_mult .. ' Mult',
                    card = card
                }
            end
        end
    end
}
return { name = {"Jokers"}, items = {PolyTheParrot_atlas, PolyTheParrot} }