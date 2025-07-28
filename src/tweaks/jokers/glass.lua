local raw_Card_shatter = Card.shatter
function Card:shatter(...)
    if self.config.center.key == 'm_glass' then
        G.GAME.BiasedBalance_shattered = (G.GAME.BiasedBalance_shattered or 0) + 1
    end
    return raw_Card_shatter(self, ...)
end

SMODS.Joker:take_ownership("glass", {
    config = { extra = 0.5 },
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra, (G.GAME.BiasedBalance_shattered or 0) * card.ability.extra + 1 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = (G.GAME.BiasedBalance_shattered or 0) * card.ability.extra + 1
            }
        end

        if context.cards_destroyed or context.remove_playing_cards or context.using_consumeable then return {} end
    end
})
