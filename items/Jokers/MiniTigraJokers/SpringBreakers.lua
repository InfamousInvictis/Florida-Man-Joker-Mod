local SpringBreakers_atlas = {
    object_type = "Atlas", 
    key = "spring_breakers_atlas", 
    path = "SpringBreakers.png", 
    px = 71, py = 95
}

local SpringBreakers = {
    object_type = "Joker",
    order = 40,
    key = "SpringBreakers",
    config = { extra = { chance = 25, money_loss = 5 } },
    rarity = 3,
    atlas = 'spring_breakers_atlas',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            (G.GAME and G.GAME.probabilities.normal or 1), 
            card.ability.extra.chance, 
            card.ability.extra.money_loss,
            colours = { G.C.DARK_EDITION }
        } }
    end,

    calculate = function(self, card, context)
        if context.destroying_card and not context.blueprint then
            if context.playing_card and context.playing_card.ability.name == 'Glass Card' then
                
                if pseudorandom('spring_breakers') < G.GAME.probabilities.normal / card.ability.extra.chance then
                    
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            ease_dollars(-card.ability.extra.money_loss)
                            card_eval_status_text(card, 'extra', nil, nil, nil, {message = '-$'..card.ability.extra.money_loss, colour = G.C.RED})
                            return true
                        end
                    }))
                    
                    return true 
                end
            end
        end
    end
}

return { name = {"Jokers"}, items = {SpringBreakers_atlas, SpringBreakers} }