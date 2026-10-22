local TheMightyManatee_atlas = {
    object_type = "Atlas",
    key = "manatee_atlas",
    path = "mighty_manatee.png", 
    px = 71, py = 95
}

local TheMightyManatee = {
    object_type = "Joker",
    order = 20,
    key = 'mighty_manatee', 
    config = { extra = { mult = 1.3334 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    atlas = 'manatee_atlas',
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card)
        return {vars = { 
            2, 
            colours = {G.C.DARK_EDITION} 
        }}
    end,

    draw = function(self, card, layer)
        if layer == 'soul' and card.children.floating_sprite then
            local cur_soul_pos = card.soul_pos or self.soul_pos
            card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, cur_soul_pos)
        end
    end,

    load = function(self, card, card_table)
        if not card.children.floating_sprite then
            card.children.floating_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[self.atlas] or G.ASSET_ATLAS['Base'], self.soul_pos)
            card.children.floating_sprite.role.draw_major = card
            card.children.floating_sprite.states.hover.can = false
            card.children.floating_sprite.states.click.can = false
        end
    end,
  
    calculate = function(self, card, context)
        if (context.individual and (context.cardarea == G.play or context.cardarea == G.jokers)) then
            if context.other_card.edition and context.other_card.edition.polychrome then
                return {
                    Xmult_mod = card.ability.extra.mult,
                    message = 'Mighty!',
                    card = card
                }
            end
        end
    end
}

return { name = {"Jokers"}, items = { TheMightyManatee_atlas, TheMightyManatee } }