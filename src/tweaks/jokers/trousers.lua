SMODS.Joker:take_ownership("trousers", {
    rarity = 2,
    config = { extra = { mult = 2, chips = 4 }, mult = 0, chips = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, localize('Two Pair', 'poker_hands'), card.ability.mult, card.ability.chips } }
    end,
    calculate = function(self, card, context)
        if context.before and (next(context.poker_hands['Two Pair']) or next(context.poker_hands['Full House'])) and not context.blueprint then
            card.ability.mult = card.ability.mult + card.ability.extra.mult
            card.ability.chips = card.ability.chips + card.ability.extra.chips
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end
        if context.joker_main and (next(context.poker_hands['Two Pair']) or next(context.poker_hands['Full House'])) then
            return {
                mult = card.ability.mult,
                extra = { chips = card.ability.chips }
            }
        end

        if context.joker_main then
            return {}
        end
    end
})
