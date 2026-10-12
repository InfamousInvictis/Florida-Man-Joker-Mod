local fore_atlas_1 = { object_type = "Atlas", key = "fore_1", path = "Fore.png", px = 71, py = 95 }
local fore_atlas_2 = { object_type = "Atlas", key = "fore_2", path = "Fairway.png", px = 71, py = 95 }
local fore_atlas_3 = { object_type = "Atlas", key = "fore_3", path = "Sandtrap.png", px = 71, py = 95 }
local fore_atlas_4 = { object_type = "Atlas", key = "fore_4", path = "Green.png", px = 71, py = 95 }

local foreJoker = {
   object_type = "Joker",
   key = "fore",
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
            card.ability.extra.x_mult },
         colours = { G.C.DARK_EDITION }
      }
   end,
   --pools = {["Fore!"] = true},
   calculate = function(self, card, context)
      if context.joker_main and card.ability.extra.x_mult > 1 then
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
         local col = G.C.WHITE
         local new_atlas = 'fore_1'
         
         if card.ability.extra.hands_played + 1 < card.ability.extra.hands_required then return {
            message = 'On the Fairway!',
            col = G.C.BLUE,
            new_atlas = 'fore_2'
         }
         elseif card.ability.extra.hands_played + 1 == card.ability.extra.hands_required then return {
            message = 'In the bunker!',
            col = G.C.GREEN,
            new_atlas = 'fore_3'
         }
         elseif card.ability.extra.hands_played == card.ability.extra.hands_required then return {
            message = 'On the Green!',
            col = G.C.GOLD,
            new_atlas = 'fore_4'
         }
         elseif card.ability.extra.hands_played > card.ability.extra.hands_required then return {
            message = 'Missed...',
            col = G.C.RED,
            new_atlas = 'fore_1'
         }
         end

         if card.config.center.atlas ~= new_atlas then
            card.config.center.atlas = new_atlas
            card:set_sprites(nil, card.config.center)
         end

         return {
            message = msg,
               colour = col,
               card = card
         }
      end

   
      if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
         local success = false
         if card.ability.extra.hands_played == card.ability.extra.hands_required then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
            success = true
         end

         card.ability.extra.hands_played = 0
         card.ability.extra.hands_required = pseudorandom("fore", 2, 5)

         card.config.center.atlas = 'fore_1'
         card:set_sprites(nil, card.config.center)

         if success then
            return {
               message = "+X"..card.ability.extra.x_mult_mod,
               colour = G.C.MULT,
               card = card
            }
         else
            return {
               message = "Reset!",
               colour = G.C.ORANGE,
               card = card
               }
         end
      end
   end
}

return { name = {"Jokers"}, items = {fore_atlas_1, fore_atlas_2, fore_atlas_3, fore_atlas_4, foreJoker} }
