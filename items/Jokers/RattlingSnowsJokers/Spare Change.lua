local spare_change_atlas = {
	object_type = "Atlas", 
	key = "spare_change_atlas", 
	path = "spare_change.png", 
	px = 71, 
	py = 95
}

local spare_change = {
    object_type = "Joker",
    order = 12,
    key = "spare_change",
    config = { 
        extra = {
            money_mod = 2,
            cur_money = 0,
            money_limit = 10
        }
    },
    rarity = 2,
    atlas = 'spare_change_atlas',
	pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
        return {vars = {
            card.ability.extra.money_mod,
            card.ability.extra.money_limit,
            card.ability.extra.cur_money,
            colours={G.C.DARK_EDITION}
        }}
    end,

    calculate = function(self,card,context)
        if context.setting_blind then
            if G.GAME.dollars >= card.ability.extra.money_mod then
                ease_dollars(-card.ability.extra.money_mod)
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = "-$"..card.ability.extra.money_mod, colour = G.C.RED })
                card.ability.extra.cur_money = card.ability.extra.cur_money + card.ability.extra.money_mod
            end
        end
        if card.ability.extra.cur_money >= card.ability.extra.money_limit then
            card.ability.extra.cur_money = 0
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:start_dissolve()
                    return true
                end
            })) 
            create_joker('Joker', nil, nil, nil, 0.99)
        end
    end
}
return { name = {"Jokers"}, items = {spare_change_atlas, spare_change} }