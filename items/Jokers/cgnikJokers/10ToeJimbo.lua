local ToeJimbo_atlas = {
	object_type = "Atlas", 
	key = "ToeJimbo_atlas", 
	path = "ToeJimbo.png", 
	px = 71, 
	py = 95
}

local ToeJimbo = {
    object_type = "Joker",
    order = 1,
    key = "10ToeJimbo",
    config = { 
        extra = {
            dollars = 10
        }
    },
    rarity = 2,
    atlas = 'ToeJimbo_atlas',
	pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
        return {vars = {
            card.ability.extra.dollars,
            colours={G.C.DARK_EDITION}
        }}
    end,

    calculate = function(self,card,context)
        if context.after and context.main_eval then
            local chipsThisHand = hand_chips * mult
            local requirement = G.GAME.blind.chips
            if chipsThisHand > requirement then
                return {
                    dollars = 10
                }
            end
        end
    end
}
return { name = {"Jokers"}, items = {ToeJimbo_atlas, ToeJimbo} }