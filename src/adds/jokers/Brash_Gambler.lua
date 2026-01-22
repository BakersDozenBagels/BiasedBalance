SMODS.Joker {
    atlas = "Joker",
    key = "BrashGambler",
    pos = {
        x = 0,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { odds1 = 2, odds2 = 4, mult1 = 2, mult2 = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds1, card.ability.extra.mult1, card.ability.extra.odds2, card.ability.extra.mult2 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local res = nil
            if pseudorandom('j_biasedBalance_BrashGambler') * card.ability.extra.odds2 < G.GAME.probabilities.normal then
                res = {
                    x_mult = card.ability.extra.mult2
                }
            end
            if pseudorandom('j_biasedBalance_BrashGambler') * card.ability.extra.odds1 < G.GAME.probabilities.normal then
                res = {
                    x_mult = card.ability.extra.mult1,
                    extra = res
                }
            end
            return res, true
        end
    end
}