local fore_atlas_1 = { object_type = "Atlas", key = "fore_1", path = "Fore.png", px = 71, py = 95 }
local fore_atlas_2 = { object_type = "Atlas", key = "fore_2", path = "Fairway.png", px = 71, py = 95 }
local fore_atlas_3 = { object_type = "Atlas", key = "fore_3", path = "Sandtrap.png", px = 71, py = 95 }
local fore_atlas_4 = { object_type = "Atlas", key = "fore_4", path = "Green.png", px = 71, py = 95 }

local foreJoker = {
   object_type = "Joker",
   key = "FloridaFore",
   pos = { x = 0, y = 0 },
   atlas = "fore_1",
   order = 9,
   rarity = 3,
   cost = 4,
   blueprint_compat = true,
   eternal_compat = true, 
   perishable_compat = true,
   config = { extra = {
      x_mult_mod = 0.25,
      x_mult = 1,
      hands_played = 0,
      hands_required = 4
   }},
   loc_vars = function(self, info_queue, card)
      return { vars = { 
            card.ability.extra.x_mult_mod, 
            card.ability.extra.hands_required, 
            card.ability.extra.hands_played, 
            card.ability.extra.x_mult } }
   end,
   --pools = {["Fore!"] = true},
   calculate = function(self, card, context)
      if context.fore_main then
         return {
            Xmult_mod = card.ability.extra.x_mult,
            message = 'X' .. card.ability.extra.x_mult .. ' Mult!',
            colour = G.C.MULT,
            card = card
         }
      end
      
      if context.before and not context.blueprint then
         card.ability.extra.hands_played = card.ability.extra.hands_played + 1
         local msg = ''
         colour = G.C.WHITE
         local new_atlas = 'fore_1'
         
         if card.ability.extra.hands_played + 1 < card.ability.extra.hands_required then return {
            message = 'On the Fairway!',
            colour = G.C.BLUE,
            new_atlas = 'fore_2'
         }
         elseif card.ability.extra.hands_played + 1 == card.ability.extra.hands_required then return {
            message = 'In the bunker!',
            colour = G.C.GREEN,
            new_atlas = 'fore_3'
         }
         elseif card.ability.extra.hands_played == card.ability.extra.hands_required then return {
            message = 'On the Green!',
            colour = G.C.GOLD,
            new_atlas = 'fore_4'
         }
         elseif card.ability.extra.hands_played > card.ability.extra.hands_required then return {
            message = 'Missed...',
            colour = G.C.RED,
            new_atlas = 'fore_1'
         }
         end
      end
      if context.end_of_round and not context.blueprint then
         if card.ability.extra.hands_played == card.ability.extra.hands_required then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
         end
         card.ability.extra.hands_played = 0
         card.ability.extra.hands_required = pseudorandom("fore", 2, 5)
         if G.cardarea == G.jokers then
            return {
               message = "+X"..card.ability.extra.x_mult_mod,
               colour = G.C.MULT
            }
         end
      end
   end
}

return { name = {"Jokers"}, items = {fore_atlas_1, fore_atlas_2, fore_atlas_3, fore_atlas_4, ForeJoker} }
