G.shared_flor_extra_sprites = {}
function SMODS.current_mod.reset_game_globals(run_start)
	if run_start then
        G.shared_flor_extra_sprites["Seagull_Splat"] = Sprite(0,0,G.CARD_W,G.CARD_H,G.ASSET_ATLAS["flor_seagull_splat_wild_atlas"], {x=0,y=0})
	end
end
SMODS.DrawStep {
    key = 'seagull_splat_wild_atlas',
    order = 1,
    func = function(self)
        if self.ability.temp_seagull_splat then
            G.shared_flor_extra_sprites["Seagull_Splat"].role.draw_major = self
            G.shared_flor_extra_sprites["Seagull_Splat"]:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}