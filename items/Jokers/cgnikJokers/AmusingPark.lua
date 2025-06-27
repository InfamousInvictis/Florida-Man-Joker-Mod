local AmusingPark_atlas = {
	object_type = "Atlas", 
	key = "AmusingPark_atlas", 
	path = "AmusingPark.png", 
	px = 71, 
	py = 95
}

local AmusingPark = {
    object_type = "Joker",
    order = 2,
    key = "AmusingPark",
    config = { 
        extra = {
            scaling = 0.1,
            mult = 1,
            poker_hands = {},
            poker_hands_formatted = ""
        }
    },
    rarity = 2,
    atlas = 'AmusingPark_atlas',
	pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
        return {vars = {
            card.ability.extra.scaling,
            card.ability.extra.mult,
            localize(card.ability.extra.poker_hands, "poker_hands"),
            card.ability.extra.poker_hands_formatted,
            colours={G.C.DARK_EDITION}
        }}
    end,

    calculate = function(self,card,context)
        function updateFormattedList()
            if #card.ability.extra.poker_hands == 0 then
                card.ability.extra.poker_hands_formatted = "None"
            elseif #card.ability.extra.poker_hands == 1 then
                card.ability.extra.poker_hands_formatted = card.ability.extra.poker_hands[1]
            elseif #card.ability.extra.poker_hands == 2 then
                card.ability.extra.poker_hands_formatted = card.ability.extra.poker_hands[1].." and "..card.ability.extra.poker_hands[2]
            else
                for i,v in ipairs(card.ability.extra.poker_hands) do
                    if i == 1 then
                        card.ability.extra.poker_hands_formatted = card.ability.extra.poker_hands[1]
                    elseif i == #card.ability.extra.poker_hands then
                        card.ability.extra.poker_hands_formatted = card.ability.extra.poker_hands_formatted..", and "..v 
                    else
                        card.ability.extra.poker_hands_formatted = card.ability.extra.poker_hands_formatted..", "..v
                    end
                end 
            end
        end
        
        if context.joker_main then
            return {
                Xmult = card.ability.extra.mult
            }
        end

        if context.before and context.main_eval and not context.blueprint then
            local unique = true
            for i,v in ipairs(card.ability.extra.poker_hands) do
                if context.scoring_name == v then
                    unique = false
                    break
                end
            end
            if unique then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.scaling
                card.ability.extra.poker_hands[#card.ability.extra.poker_hands+1] = context.scoring_name
                updateFormattedList()
                return {
                    message = "+X"..card.ability.extra.scaling.." Mult",
                    colour = G.C.MULT
                } 
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and G.GAME.blind.boss then
            card.ability.extra.mult = 1
            card.ability.extra.poker_hands = {}
            updateFormattedList()
            return {
                message = localize('k_reset')
            }
        end
    end
}
return { name = {"Jokers"}, items = {AmusingPark_atlas, AmusingPark} }