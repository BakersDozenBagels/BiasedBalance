SMODS.Stake {
	key = "silver",
	pos = { 
        x = 1,
        y = 0 
    },
	atlas = "stakes",
	above_stake = "gold",
	applied_stakes = { 
        "gold" 
    },
	sticker_pos = {x = 1, y = 0},
	sticker_atlas = 'stickers',
	prefix_config = {above_stake = { mod = false },applied_stakes = { mod = false }},
	modifiers = function()
		G.GAME.win_ante = 9
		G.GAME.Biased_Balance.silver_stake_active = true
	end,
	shiny = true,
	order = 10,
	colour = HEX("868686"),
}