SMODS.Seal {
    key = 'Tangerine',
    name = "Tangerine",
    badge_colour = G.C.BIASEDBALANCE_TANGERINE,
    atlas = 'seals',
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = {
            a_mult = 2,
            mult = 0,
            num_cards = 5,
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.seal.extra.mult, card.ability.seal.extra.a_mult, card.ability.seal.extra.num_cards } }
    end,
    calculate = function(self, card, context)
        if context.before and #context.scoring_hand >= card.ability.seal.extra.num_cards and context.cardarea == G.play then
            card.ability.seal.extra.mult = card.ability.seal.extra.mult + card.ability.seal.extra.a_mult
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.RED
            }
        end
        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = card.ability.seal.extra.mult,
            }
        end
        if context.main_scoring and context.cardarea == G.hand and not context.end_of_round then
            return {
                    mult = card.ability.seal.extra.mult
                }
            end
    end,
}