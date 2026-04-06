local MightyManateeBG_atlas = {
    object_type = "Atlas", 
    key = "MightyManateeBG", 
    path = "MightyManateeBG.png", 
    px = 71, py = 95
}

local MightyManatee_atlas = {
    object_type = "Atlas", 
    key = "MightyManatee", 
    path = "MightyManatee.png", 
    px = 71, py = 95
}

local TheMightyManatee = {
    object_type = "Joker",
    order = 20,
    key = "TheMightyManatee",
    config = { 
        extra = {
            x_mult = 2,
            base_poly = 1.5
        }
    },
    rarity = 3,
    atlas = 'MightyManateeBG',
	pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    --BUG: When glossy effects are applied to this card, the Manatee sprite itself disappears...? Not sure why
    --tried a few different things to fix it, but to no success so far
    draw = function(self, card, layer)
        if layer ~= 'card' then return end
        if not G.shared_flor_extra_sprites["MightyManatee"] then
            G.shared_flor_extra_sprites["MightyManatee"] = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["flor_MightyManatee"], {x=0, y=0})
        end
        local body_sprite = G.shared_flor_extra_sprites["MightyManatee"]
        body_sprite.role.draw_major = card
        body_sprite.video_threshold = card.video_threshold
        
        body_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center)
        
        if card.edition and card.children.center then
            body_sprite:draw_shader(card.edition.shader or 'holo', nil, nil, nil, card.children.center)
        end
    end,
  
    loc_vars = function(self, info_queue, card)
        local poly_count = 0
        if G.jokers then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.edition and joker.edition.polychrome then poly_count = poly_count + 1 end
            end
        end
        local current_total = math.pow(card.ability.extra.x_mult, poly_count)
        return {
            vars = { card.ability.extra.x_mult, current_total },
            main_col = G.C.DARK_EDITION
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.edition and context.other_card.edition.polychrome then
                return {
                    Xmult_mod = card.ability.extra.x_mult / card.ability.extra.base_poly,
                    message = 'Mighty!',
                    card = card
                }
            end
        end
        
        if context.joker_main then
            local poly_jokers = 0
            for _, joker in ipairs(G.jokers.cards) do
                if joker.edition and joker.edition.polychrome then
                    poly_jokers = poly_jokers + 1
                end
            end

            if poly_jokers > 0 then
                local upgrade_factor = card.ability.extra.x_mult / card.ability.extra.base_poly
                return {
                    Xmult_mod = math.pow(upgrade_factor, poly_jokers),
                    message = 'Mighty Jokers!',
                    colour = G.C.DARK_EDITION,
                    card = card
                }
            end
        end
    end
}

return { name = {"Jokers"}, items = {MightyManatee_atlas, MightyManateeBG_atlas, TheMightyManatee} }