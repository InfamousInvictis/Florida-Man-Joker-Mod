local key_lime_pie_atlas = {
	object_type = "Atlas", 
	key = "key_lime_pie_atlas", 
	path = "key_lime_pie.png", 
	px = 71, 
	py = 95
}

local key_lime_pie = {
    object_type = "Joker",
    order = 24,
    key = "key_lime_pie",
    config = { 
        extra = {
            rounds = 2,
            cur_rounds = 0,
        }
    },
    rarity = 1,
    atlas = 'key_lime_pie_atlas',
	pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
        return {vars = {
            card.ability.extra.rounds,
            card.ability.extra.cur_rounds,
            colours={G.C.DARK_EDITION}
        }}
    end,

    calculate = function(self,card,context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if G.consumeables.config.card_limit == #G.consumeables.cards then
                card.ability.extra.cur_rounds = card.ability.extra.cur_rounds + 1
                if card.ability.extra.cur_rounds ~= card.ability.extra.rounds then
                    return {
                        message = card.ability.extra.cur_rounds..'/'..card.ability.extra.rounds,
                        colour = G.C.FILTER
                    }
                end
            end
            if card.ability.extra.cur_rounds == card.ability.extra.rounds then
                for i=#G.consumeables.cards, 1, -1 do
                    card.ability.extra_value = card.ability.extra_value + G.consumeables.cards[i].sell_cost * 3
                    G.consumeables.cards[i]:start_dissolve(nil, i == 1)
                end
                card:set_cost()
                card.ability.extra.cur_rounds = 0
                return {
                    message = localize('k_val_up'),
                    colour = G.C.MONEY
                }
            end
        end
        if G.consumeables.config.card_limit > #G.consumeables.cards and card.ability.extra.cur_rounds ~= 0 then
            card.ability.extra.cur_rounds = 0
            return {
                message = "Reset!"
            }
        end
    end
}
return { name = {"Jokers"}, items = {key_lime_pie_atlas, key_lime_pie} }