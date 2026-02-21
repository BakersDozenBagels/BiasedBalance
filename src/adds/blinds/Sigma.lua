SMODS.Blind {
    key = "Sigma",
    atlas = "blinds",
    pos = {
        x = 0,
        y = 8
    },
    boss_colour = HEX("bb89ba"),
    boss = {
		min = 4,
	},
    calculate = function(self, card, context)
        if context.final_scoring_step then
            local tax = math.abs(G.GAME.blind.chips * 0.5)
            local score = hand_chips * mult

            if score > tax then
                hand_chips = tax
                mult = 1
            end
        end
    end
}