SMODS.Joker:take_ownership("todo_list", {
    rarity = 1,
    cost = 5,
    perishable_compat = false,
    config = { extra = { dollars = 4, poker_hand = 'High Card', dx_mult = 0.15, played = false } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dx_mult, localize(card.ability.to_do_poker_hand, 'poker_hands'), card.ability.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.to_do_poker_hand then
            if card.ability.extra.played then
                return {}
            end
            card.ability.x_mult = card.ability.x_mult + card.ability.extra.dx_mult
            card.ability.extra.played = true
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.x_mult } },
                colour = G.C.RED
            }
        end
        if context.end_of_round and not context.blueprint then
            card.ability.extra.played = false
        end
        if context.joker_main then
            return { x_mult = card.ability.x_mult }
        end
    end,
})