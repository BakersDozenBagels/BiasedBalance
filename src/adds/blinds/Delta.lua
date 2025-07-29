SMODS.Blind {
    key = "Delta",
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
        if context.main_scoring then
            if context.debuff_card and context.debuff_card.area ~= G.hand then
                return {
                    debuff = true
                }
            end
        end
        end
    end
}
