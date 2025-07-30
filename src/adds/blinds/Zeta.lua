SMODS.Blind {
    key = "Zeta",
    --atlas = "blinds",
    pos = {
        x = 0,
        y = 0
    },
    discovered = false,
    unlocked = true,
    order = 1,
    boss_colour = HEX("348a7b"),
    boss = {
		min = 0,
	},
    recalc_debuff = function(self, card, from_blind)
        if card.area ~= G.jokers and not G.GAME.blind.disabled then
			if BiasedBalance.is_even(card)
			then
				return true
			end
			return false
		end
    end,
}