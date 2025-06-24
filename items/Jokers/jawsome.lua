-- TheOneGoofAli was here!
local jawsome_atlas = {
	object_type = "Atlas", 
	key = "FloridaJawsome", 
	path = "jawsome.png", 
	px = 71, 
	py = 95
}

local jawsome = {
    object_type = "Joker",
    order = 34,
    key = "jawsome",
    config = {
    },
    rarity = 2,
    atlas = 'FloridaJawsome',
	pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
  
    loc_vars = function(self, info_queue, card)

    end,
  
    calculate = function(self, card, context)
		if context.skip_blind then
			if #G.jokers.cards > 0 then
				local jokerlist, itercount, iterlimit = G.jokers.cards, 0, 64
				local seljoker = pseudorandom_element(jokerlist, pseudoseed('floridajawz'))
				while seljoker.edition and itercount < iterlimit do
					itercount = itercount + 1
					seljoker = pseudorandom_element(jokerlist, pseudoseed('floridajawz'))
				end
				
				if not seljoker.edition then
					local seledition = poll_edition('floridamen', nil, false, true)
					seljoker:set_edition(seledition, true)
					return { message = localize('k_upgrade_ex'), message_card = seljoker }
				else
					return { message = localize('k_nope_ex') }
				end
			end
		end
	end
}
return { name = {"Jokers"}, items = {jawsome_atlas, jawsome} }