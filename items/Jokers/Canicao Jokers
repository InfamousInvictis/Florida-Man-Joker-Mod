   atlas = "Fore!",
   pos = { x = 0, y = 3 },
   rarity = 3,
   cost = 4,
   blueprint_compat = true,
   config = { extra = {
      x_mult_mod = 0.25,
      x_mult = 1,
      hands_played = 0,
      hands_required = 4
   }},
   loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.x_mult_mod, card.ability.extra.hands_required, card.ability.extra.hands_played, card.ability.extra.x_mult } }
   end,
   pools = {["Fore!"] = true},
   calculate = function(self, card, context)
      if context.Fore!_main then
         return {
            Xmult = card.ability.extra.x_mult
         }
      end
      if context.before and not context.blueprint then
         card.ability.extra.hands_played = card.ability.extra.hands_played + 1
         if card.ability.extra.hands_played + 1 < card.ability.extra.hands_required then return {
            message = 'On the Fairway!',
            colour = G.C.BLUE
         }
         elseif card.ability.extra.hands_played + 1 == card.ability.extra.hands_required then return {
            message = 'In the bunker!',
            colour = G.C.GREEN
         }
         elseif card.ability.extra.hands_played == card.ability.extra.hands_required then return {
            message = 'On the Green!',
            colour = G.C.GOLD
         }
         elseif card.ability.extra.hands_played > card.ability.extra.hands_required then return {
            message = 'Missed...',
            colour = G.C.RED
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

return { name = {"Jokers"}, items = {Fore!_atlas, Fore!} }
