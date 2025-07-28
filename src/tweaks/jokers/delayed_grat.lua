SMODS.Joker:take_ownership("delayed_grat", {
    rarity = 2,
    blueprint_compat = true,
    config = { extra = { dollars = 3, cards = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.cards } }
    end,
    calculate = function(self, card, context)
        if context.discard and #context.full_hand <= card.ability.extra.cards and context.other_card == context.full_hand[#context.full_hand] then
            return { dollars = card.ability.extra.dollars }
        end
    end,
    calc_dollar_bonus = function(self, card) end
})
