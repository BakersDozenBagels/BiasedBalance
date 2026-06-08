SMODS.Joker:take_ownership("idol", { 
    config = { extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        local idol_card = G.GAME.current_round.bbalance_idol_card or { rank = 'Ace', suit = 'Spades' }
        return { vars = { card.ability.extra.xmult, localize(idol_card.rank, 'ranks'), localize(idol_card.suit, 'suits_plural'), colours = { G.C.SUITS[idol_card.suit] } } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card:get_id() == G.GAME.current_round.bbalance_idol_card.id and
            context.other_card:is_suit(G.GAME.current_round.bbalance_idol_card.suit) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
 })

