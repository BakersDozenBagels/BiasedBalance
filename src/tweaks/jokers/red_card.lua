SMODS.Joker:take_ownership("red_card", {
    rarity = 1,
    config = { extra = 0.05 },
    cost = 3,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.skipping_booster and not context.blueprint then
            card.ability.x_mult = card.ability.x_mult + card.ability.extra
            G.E_MANAGER:add_event(Event {
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.x_mult } },
                        colour = G.C.RED,
                        delay = 0.45,
                        card = card
                    })
                    return true
                end
            })
            return {}
        end
        if context.joker_main then
            return { x_mult = card.ability.x_mult }
        end
    end,
})