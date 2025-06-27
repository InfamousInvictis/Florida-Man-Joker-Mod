local sand_dollar_atlas = {
	object_type = "Atlas", 
	key = "sand_dollar_atlas", 
	path = "sand_dollar.png", 
	px = 71, 
	py = 95
}

local sand_dollar = {
    object_type = "Joker",
    order = 19,
    key = "sand_dollar",
    config = { 
        extra = {
            money_mod = 1,
        }
    },
    rarity = 2,
    atlas = 'sand_dollar_atlas',
	pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
        return {vars = {
            card.ability.extra.money_mod,
            colours={G.C.DARK_EDITION}
        }}
    end,

    calculate = function(self,card,context)
        if context.after and context.cardarea == G.jokers then
            for index, other_card in ipairs(G.hand.cards) do
                if other_card.config.center == G.P_CENTERS["m_gold"] then
                    other_card:juice_up(0.3, 0.3)
                    card_eval_status_text(other_card, 'extra', nil, nil, nil, { message = "$"..card.ability.extra.money_mod, colour = G.C.MONEY })
                    ease_dollars(card.ability.extra.money_mod)
                end              
            end
        end
    end
}
return { name = {"Jokers"}, items = {sand_dollar_atlas, sand_dollar} }