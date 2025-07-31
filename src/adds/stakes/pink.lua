SMODS.Stake {
	key = "pink",
	pos = { 
        x = 0,
        y = 0 
    },
	atlas = "stakes",
	applied_stakes = { 
        "gold" 
    },
	modifiers = function()
		G.GAME.win_ante = 9
		if G.GAME.ante == 1 and G.GAME.blind.boss then
			showdown = true
		end
	end,
	shiny = true,
	order = 9,
	colour = HEX("ff27cc"),
}