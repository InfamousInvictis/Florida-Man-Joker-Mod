local GatorAid_atlas = {
    object_type = "Atlas", 
    key = "GatorAid_atlas", 
    path = "GatorAid.png", 
    px = 71, py = 95
}

local GatorAid = {
    object_type = "Joker",
    order = 28,
    key = "GatorAid",
    config = { extra = { xmult = 2, } },
    rarity = 1,
    atlas = 'GatorAid_atlas',
    pos = { x = 0, y = 0 },
    cost = 4,
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
        if context.joker_main and card.ability.extra.xmult > 1 then
            for _, v in ipairs(context.full_hand) do
				if v.debuff then
					return {
                        xmult = card.ability.extra.xmult,
                    }
				end
			end
        end
    end
}

return { name = {"Jokers"}, items = {GatorAid_atlas, GatorAid} }
