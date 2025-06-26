local wilson_atlas = {
	object_type = "Atlas", 
	key = "wilson_atlas", 
	path = "wilson.png", 
	px = 71, 
	py = 95
}

local wilson = {
    object_type = "Joker",
    order = 21,
    key = "wilson",
    config = { 
        
    },
    rarity = 1,
    atlas = 'wilson_atlas',
	pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self,info_queue,card)
        return {vars = {
            colours={G.C.DARK_EDITION}
        }}
    end,

    calculate = function(self,card,context)
        local has_wilson = next(SMODS.find_card("j_flor_wilson"))
        if G.play ~= nil and has_wilson then
            for _, card in ipairs(G.play.cards) do
              local saved = card.ability.wilson_edit
              if context.before then
                if not card.debuff and card:is_face() and card.config.center == G.P_CENTERS.m_mult and saved == nil then
                  flor_ability_calculate(card, "*", 2, nil, {"mult"}, false, true, "ability.extra")
                  flor_ability_calculate(card, "*", 2, nil, {"h_mult"}, false, true, "ability.extra")
                  flor_ability_calculate(card, "*", 2, nil, {"perma_mult"},  false, true, "ability.extra")
                  card.ability.wilson_edit = true
                end
              end

              if context.final_scoring_step then
                if saved ~= nil then
                  flor_ability_calculate(card, "/", 2, nil, {"mult"}, false, true, "ability.extra")
                  flor_ability_calculate(card, "/", 2, nil, {"h_mult"}, false, true, "ability.extra")
                  flor_ability_calculate(card, "/", 2, nil, {"perma_mult"},  false, true, "ability.extra")
                  card.ability.wilson_edit = nil
                end
              end
            end
        end
    end
}
return { name = {"Jokers"}, items = {wilson_atlas, wilson} }