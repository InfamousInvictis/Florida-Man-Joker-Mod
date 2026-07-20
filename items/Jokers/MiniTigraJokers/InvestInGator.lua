local InvestInGator_atlas = {
    object_type = "Atlas", 
    key = "invest_in_gator_atlas", 
    path = "InvestInGator.png", 
    px = 71, py = 95
}

local InvestInGator = {
    object_type = "Joker",
    order = 26,
    key = "InvestInGator",
    config = { extra = { tag_to_give = "tag_investment" } },
    rarity = 2,
    atlas = 'invest_in_gator_atlas',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
  
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            colours = { G.C.DARK_EDITION }
        } }
    end,

    calculate = function(self, card, context)
        if context.buying_card and context.card and context.card.config.center.set == 'Voucher' then
            
            card:juice_up(0.3, 0.3)
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(Tag('tag_investment'))
                    play_sound('generic1', 1, 0.5)
                    return true
                end
            }))
            
            return {
                message = 'Gator Tag!',
                colour = G.C.MONEY,
                card = card
            }
        end
    end
}

return { name = {"Jokers"}, items = {InvestInGator_atlas, InvestInGator} }