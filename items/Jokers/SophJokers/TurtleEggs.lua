local TurtleEggs_atlas = {
    object_type = "Atlas", 
    key = "TurtleEggs_atlas", 
    path = "TurtleEggs.png", 
    px = 71, py = 95
}

local TurtleEggs = {
    object_type = "Joker",
    order = 53,
    key = "TurtleEggs",
    config = { extra = { total_rounds = 2, turtle_rounds = 0, copies = 2 } },
    rarity = 2,
    atlas = 'TurtleEggs_atlas',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
  
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.j_egg
        return { vars = { 
            card.ability.extra.total_rounds,
            card.ability.extra.turtle_rounds,
            colours = { G.C.DARK_EDITION }
        } }
    end,
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.extra.turtle_rounds >= card.ability.extra.total_rounds) and not context.blueprint then
            for i=1, card.ability.extra.copies do
                if #G.jokers.cards <= (G.jokers.config.card_limit - (card.edition and card.edition.negative and 1 or 0)) then
                    SMODS.add_card { key = "j_egg" }
                else
                    return { message = localize('k_no_room_ex') }
                end
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.turtle_rounds = card.ability.extra.turtle_rounds + 1
            if card.ability.extra.turtle_rounds == card.ability.extra.total_rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.turtle_rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.turtle_rounds .. '/' .. card.ability.extra.total_rounds) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end
}

return { name = {"Jokers"}, items = {TurtleEggs_atlas, TurtleEggs} }
