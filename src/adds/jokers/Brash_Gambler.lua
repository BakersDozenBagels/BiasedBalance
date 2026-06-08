SMODS.Joker {
    atlas = "Joker",
    key = "BrashGambler",
    pos = {
        x = 6,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { odds1 = 2, odds2 = 4, x_mult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds1, card.ability.extra.x_mult, card.ability.extra.odds2, card.ability.extra.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('j_biasedBalance_BrashGambler') * card.ability.extra.odds2 < G.GAME.probabilities.normal then
                SMODS.calculate_effect {
                    x_mult = card.ability.extra.x_mult,
                    card = card,
                }
            end
            if pseudorandom('j_biasedBalance_BrashGambler') * card.ability.extra.odds1 < G.GAME.probabilities.normal then
                SMODS.calculate_effect {
                    x_mult = card.ability.extra.x_mult,
                    card = card,
                }
            end
        end
    end
}