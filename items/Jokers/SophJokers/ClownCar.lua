local ClownCar_atlas = {
    object_type = "Atlas", 
    key = "ClownCar_atlas", 
    path = "ClownCar.png", 
    px = 71, py = 95
}

local ClownCar = {
    object_type = "Joker",
    order = 49,
    key = "ClownCar",
    config = { extra = { x_mult = 1, x_mult_gain = 0.1 } },
    rarity = 2,
    atlas = 'ClownCar_atlas',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
  
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.x_mult,
            card.ability.extra.x_mult_gain,
            colours = { G.C.DARK_EDITION }
        } }
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.sell_cost = 0
        for _, v in ipairs(G.jokers.cards) do
            v.sell_cost = 0
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        for _, v in ipairs(G.jokers.cards) do
            if v.set_cost then
                v:set_cost()
            end
        end
    end,

    calculate = function(self, card, context)
        if context.selling_card and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "x_mult",
                scalar_value = "x_mult_gain",
                operation = "+",
                message_colour = G.C.RED,
            })
            return nil, true
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

local atd_ref = Card.add_to_deck
Card.add_to_deck = function(self, from_debuff)
    local ret = atd_ref(self, from_debuff)
    if next(SMODS.find_card("j_flor_ClownCar")) then
        self.sell_cost = 0
    end
    return ret
end

local sc_ref = Card.set_cost
function Card.set_cost(self)
    local ret = sc_ref(self)
    if self.added_to_deck then
        if next(SMODS.find_card("j_flor_ClownCar")) then
            self.sell_cost = 0
        end
    end
    return ret
end

return { name = {"Jokers"}, items = {ClownCar_atlas, ClownCar} }
