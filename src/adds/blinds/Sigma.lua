SMODS.Blind {
    key = "Sigma",
    --atlas = "blinds",
    pos = {
        x = 0,
        y = 0
    },
    discovered = false,
    unlocked = true,
    order = 1,
    boss_colour = HEX("883a3b"),
    boss = {
		min = 5,
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