local mugshot_atlas = {
	object_type = "Atlas", 
	key = "mugshot_atlas", 
	path = "mugshot.png", 
	px = 71, 
	py = 95
}

local mugshot = {
    object_type = "Joker",
    order = 4,
    key = "mugshot",
    config = { 
        extra = {
            money_mod = 1,
            mindebuff = 5,
            maxdebuff = 10,
            cur_money = 0,
        }
    },
    rarity = 1,
    atlas = 'mugshot_atlas',
	pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
      card.ability.extra.cur_money = 0
      if G.playing_cards then
          for index, other_card in ipairs(G.playing_cards) do
            if other_card.ability.flor_disabled_for and other_card.ability.flor_disabled_for.effect == "money_gain" then
                card.ability.extra.cur_money = card.ability.extra.cur_money + other_card.ability.flor_disabled_for.lvl
            end              
          end
      end
        return {vars = {
            card.ability.extra.money_mod,
            card.ability.extra.mindebuff,
            card.ability.extra.maxdebuff,
            card.ability.extra.cur_money,
            colours={G.C.DARK_EDITION}
        }}
    end,

    calculate = function(self,card,context)
        if context.cardarea == G.play and context.full_hand then
            for index, other_card in ipairs(context.full_hand) do
                if other_card:is_face() and not other_card.ability.flor_disabled_for then
                    other_card:juice_up(0.3, 0.3)
                    other_card.ability.flor_disabled_for = {rounds = math.random(card.ability.extra.mindebuff, card.ability.extra.maxdebuff)+2, effect = "money_gain", lvl = card.ability.extra.money_mod}
                end              
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
      local money = 0
      if G.playing_cards then
          for index, other_card in ipairs(G.playing_cards) do
            if other_card.ability.flor_disabled_for and other_card.ability.flor_disabled_for.effect == "money_gain" then
                money = money + other_card.ability.flor_disabled_for.lvl
            end              
          end
      end
      if money > 0 then
        return money
      end
    end
}
local ease_roundref = ease_round
function ease_round(mod)
    if mod ~= 0 then
        if G.playing_cards then
            for index, other_card in ipairs(G.playing_cards) do
                if other_card.ability.flor_disabled_for and other_card.ability.flor_disabled_for.rounds > 0 then
                    other_card.ability.flor_disabled_for.rounds = other_card.ability.flor_disabled_for.rounds - 1
                end              
            end
        end
    end
    
    local ref = ease_roundref(mod)
    return ref
end
return { name = {"Jokers"}, items = {mugshot_atlas, mugshot} }