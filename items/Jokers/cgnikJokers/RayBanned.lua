local RayBanned_atlas = {
	object_type = "Atlas",
	key = "RayBanned_atlas",
	path = "RayBanned.png",
	px = 71,
	py = 95
}

local RayBanned = {
    object_type = "Joker",
    order = 6,
    key = "RayBanned",
    config = { 
        extra = {
            odds = 4
        }
    },
    rarity = 2,
    atlas = 'RayBanned_atlas',
	pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
        local num,denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {vars = {
            num, denom,
            colours={G.C.DARK_EDITION}
        }}
    end,

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if not SMODS.pseudorandom_probability(card, "flor_RayBanned", 1, card.ability.extra.odds) then
                return
            end

            local othercard = context.other_card
            if othercard:is_suit("Hearts") then
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                othercard:flip()
                                play_sound('card1', 1)
                                othercard:juice_up(0.3, 0.3)
                                return true
                            end
                        }))
                        delay(0.2)
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.1,
                            func = function()
                                assert(SMODS.change_base(othercard, "Spades"))
                                return true
                            end
                        }))
                        SMODS.calculate_effect({message="Motör'd!",colour = G.C.SUITS.Spades}, othercard)
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.15,
                            func = function()
                                othercard:flip()
                                play_sound('tarot2', 1, 0.6)
                                othercard:juice_up(0.3, 0.3)
                                return true
                            end
                        }))
                        delay(0.5)
                    end
                }
            elseif othercard:is_suit("Diamonds") then
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                othercard:flip()
                                play_sound('card1', 1)
                                othercard:juice_up(0.3, 0.3)
                                return true
                            end
                        }))
                        delay(0.2)
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.1,
                            func = function()
                                assert(SMODS.change_base(othercard, "Clubs"))
                                return true
                            end
                        }))
                        SMODS.calculate_effect({message="Get Tipsy!",colour = G.C.SUITS.Clubs}, othercard)
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.15,
                            func = function()
                                othercard:flip()
                                play_sound('tarot2', 1, 0.6)
                                othercard:juice_up(0.3, 0.3)
                                return true
                            end
                        }))
                        delay(0.5)
                    end
                }
            end
        end
    end
}
return { name = {"Jokers"}, items = {RayBanned_atlas, RayBanned} }