SMODS.Stake {
	key = "pink",
	pos = { 
        x = 0,
        y = 0 
    },
	atlas = "stakes",
	above_stake = "biasedBalance_silver",
	applied_stakes = { 
        "biasedBalance_silver" 
    },
	sticker_pos = {x = 0, y = 0},
	sticker_atlas = 'stickers',
	prefix_config = {above_stake = { mod = false },applied_stakes = { mod = false }},
	modifiers = function()
		G.GAME.starting_params.hands = G.GAME.starting_params.hands - 1
		G.GAME.modifiers.money_per_hand = 2
		G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + 1
	end,
	shiny = true,
	order = 9,
	colour = HEX("ff27cc"),
}