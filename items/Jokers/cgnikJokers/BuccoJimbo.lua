local BuccoJimbo_atlas = {
	object_type = "Atlas", 
	key = "BuccoJimbo", 
	path = "BuccoJimbo.png", 
	px = 71, 
	py = 95
}

local BuccoJimbo = {
    object_type = "Joker",
    order = 8,
    key = "BuccoJimbo",
    config = { 
        extra = {
            dollars = 13,
            planet_max = 3
        }
    },
    rarity = 3,
    atlas = 'BuccoJimbo',
	pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
        return {vars = {
            card.ability.extra.dollars,
            card.ability.extra.planet_max,
            colours={G.C.DARK_EDITION}
        }}
    end,

    calculate = function(self,card,context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            local weights = {
                3, -- Joker
                3, -- Tarot
                3, -- Planets
                3, -- Money
                2, -- Spectral
                -- 1 -- Keys
            }

            local totalWeight = 0
            for i,v in ipairs(weights) do
                totalWeight = totalWeight + v
            end

            local random = pseudorandom("flor_buccojimbo",1,totalWeight)

            local itemIndex = 0
            for i,v in ipairs(weights) do
                if random > v then
                    random = random - v
                else
                    itemIndex = i
                    break
                end
            end

            if itemIndex == 1 then
                SMODS.calculate_effect({message="Joker!",colour = G.C.FILTER}, card)
                SMODS.add_card({set = "Joker",soulable = true})
                return
            elseif itemIndex == 2 then
                SMODS.calculate_effect({message="Tarot!",colour = G.C.FILTER}, card)
                SMODS.add_card({set = "Tarot",soulable = true})
                return
            elseif itemIndex == 3 then
                SMODS.calculate_effect({message="Planets!",colour = G.C.FILTER}, card)
                local planetRandom = pseudorandom("flor_buccojimbo_planets",1,card.ability.extra.planet_max)
                for count = 1,planetRandom,1 do
                    SMODS.add_card({set = "Planet",soulable = true})
                end
                return
            elseif itemIndex == 4 then
                SMODS.calculate_effect({message="Money!",colour = G.C.FILTER}, card)
                return {
                    dollars = card.ability.extra.dollars
                }
            elseif itemIndex == 5 then
                SMODS.calculate_effect({message="Spectral!",colour = G.C.FILTER}, card)
                SMODS.add_card({set = "Spectral",soulable = true})
                return
            else
                SMODS.calculate_effect({message="Keys!",colour = G.C.DARK_EDITION}, card)
                -- add the functionality for this once the keys are made, keys are currently unobtainable using buccojimbo due to the keys weight being commented out
            end
        end
    end
}
return { name = {"Jokers"}, items = {BuccoJimbo_atlas, BuccoJimbo} }