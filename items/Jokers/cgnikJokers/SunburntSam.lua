local SunburntSam_atlas = {
	object_type = "Atlas", 
	key = "SunburntSam", 
	path = "SunburntSam.png", 
	px = 71, 
	py = 95
}

local SunburntSam = {
    object_type = "Joker",
    order = 8,
    key = "SunburntSam",
    config = { 
        extra = {
            mult = 3
        }
    },
    rarity = 2,
    atlas = 'SunburntSam',
	pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
        return {vars = {
            card.ability.extra.mult,
            colours={G.C.DARK_EDITION}
        }}
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            local all_correct_suit = true
            for i,v in ipairs(G.hand.cards) do
                if v.base.suit ~= "Hearts" and v.base.suit ~= "Diamonds" then
                    all_correct_suit = false
                end
            end

            if all_correct_suit then
                return {
                    Xmult = card.ability.extra.mult,
                }
            end
        end
    end
}
return { name = {"Jokers"}, items = {SunburntSam_atlas, SunburntSam} }