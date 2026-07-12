SMODS.Blind {
    key = "Omega",
    atlas = "blinds",
    pos = {
        x = 0,
        y = 10
    },
    loc_vars = function(self)
        return { vars = { 40 + 15 * (G.GAME.round_resets.ante or 0) } }
    end,
    collection_loc_vars = function(self)
        return { vars = { "(40 + (15 * Ante))" } }
    end,
    boss_colour = HEX("e23539"),
    boss = {
		min = 5,
	},
    calculate = function(self, blind, context)
        if not blind.disabled and context.final_scoring_step then
            local subtract = 40 + 15 * (G.GAME.round_resets.ante or 0)
            print(hand_chips)
            print(subtract)
            if hand_chips - subtract <= 5 then
                subtract = hand_chips - 5
            end
            return {chip_mod = -1 * subtract}
        end
    end
}