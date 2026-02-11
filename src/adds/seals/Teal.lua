SMODS.Seal {
    key = 'Teal',
    name = "Teal",
    badge_colour = G.C.BIASEDBALANCE_TEAL,
    atlas = 'seals',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            num_scored = 1,
        }
    },
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
                G.GAME.probabilities.normal = G.GAME.probabilities.normal * 2
                card.ability.seal.extra.num_scored = card.ability.seal.extra.num_scored * 2
            return {
                message = localize('k_biasedBalance_probs'),
                colour = G.C.GREEN,
            }
        end
        if context.after and context.cardarea == G.play then
                G.GAME.probabilities.normal = G.GAME.probabilities.normal / card.ability.seal.extra.num_scored
                card.ability.seal.extra.num_scored = 1
                return {
                    message = localize('k_reset'),
                    colour = G.C.GREEN,
                }
        end
    end,
}