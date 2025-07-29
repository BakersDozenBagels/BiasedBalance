SMODS.Blind {
    key = "Epsilon",
    --atlas = "blinds",
    pos = {
        x = 0,
        y = 0
    },
    discovered = false,
    unlocked = true,
    order = 1,
    boss_colour = HEX("870f52"),
    boss = {
		min = 4,
	},
   calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers then
                return {
                    debuff = true
                }
            end
            if context.selling_card and context.card.ability.set == 'Joker' then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        blind:disable()
                        return true
                    end
                }))
            end
        end
    end
}
