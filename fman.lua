FMAN = {}

fman = SMODS.current_mod
fman_config = fman.config
fman.enabled = copy_table(fman_config)
fman = SMODS.current_mod.path