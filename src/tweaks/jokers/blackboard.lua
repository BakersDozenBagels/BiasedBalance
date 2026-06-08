SMODS.Joker:take_ownership("blackboard", { 
    config = { extra = { xmult = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, localize('Spades', 'suits_plural'), localize('Clubs', 'suits_plural') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local all_black_suits = true
            for _, playing_card in ipairs(G.hand.cards) do
                if not playing_card:is_suit('Clubs', nil, true) and not playing_card:is_suit('Spades', nil, true) then
                    all_black_suits = false
                    break
                end
            end
            if all_black_suits then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
 })