SMODS.Joker {
    atlas = "Joker",
    key = "HopelessGambler",
    pos = {
        x = 11,
        y = 7
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { odds1 = 2, odds2 = 3, odds3 = 4, mult = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds1, 
                        card.ability.extra.odds2, card.ability.extra.odds3, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local res = nil
            if pseudorandom('j_biasedBalance_HopelessGambler') * card.ability.extra.odds1 < G.GAME.probabilities.normal then
                res = {
                    mult = card.ability.extra.mult
                }
            end
            if pseudorandom('j_biasedBalance_HopelessGambler') * card.ability.extra.odds2 < G.GAME.probabilities.normal then
                res = res or {}
                res.mult = (res.mult or 0) + card.ability.extra.mult
            end
            if pseudorandom('j_biasedBalance_HopelessGambler') * card.ability.extra.odds3 < G.GAME.probabilities.normal then
                res = res or {}
                res.mult = (res.mult or 0) + card.ability.extra.mult
            end
            return res
        end
    end,
}