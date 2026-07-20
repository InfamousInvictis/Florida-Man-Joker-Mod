local RedHanded_atlas = {
	object_type = "Atlas",
	key = "RedHanded_atlas",
	path = "RedHanded.png",
	px = 71,
	py = 95
}

local RedHanded = {
    object_type = "Joker",
    order = 7,
    key = "RedHanded",
    config = {
        extra = {
            odds = 4
        }
    },
    rarity = 2,
    atlas = 'RedHanded_atlas',
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
            if not SMODS.pseudorandom_probability(card, "flor_RedHanded", 1, card.ability.extra.odds) then
                return
            end

            local othercard = context.other_card
            if othercard:is_suit("Spades") then
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
                                assert(SMODS.change_base(othercard, "Hearts"))
                                return true
                            end
                        }))
                        SMODS.calculate_effect({message="<3",colour = G.C.SUITS.Hearts}, othercard)
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
            elseif othercard:is_suit("Clubs") then
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
                                assert(SMODS.change_base(othercard, "Diamonds"))
                                return true
                            end
                        }))
                        SMODS.calculate_effect({message="Shine On!",colour = G.C.SUITS.Diamonds}, othercard)
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
return { name = {"Jokers"}, items = {RedHanded_atlas, RedHanded} }