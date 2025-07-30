SMODS.Seal {
    key = 'Teal',
    badge_colour = HEX("008080"),
    --atlas = 'seals',
    pos = {
        x = 0,
        y = 0
    },
calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.hand then
            if context.mod_probability and not context.blueprint then
                return {
                    numerator = context.numerator * 2
                }
            end
        end
    end,
}