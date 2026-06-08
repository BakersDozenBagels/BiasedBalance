SMODS.Joker:take_ownership("ancient", { 
    config = { extra = { xmult = 1.5 } },
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.bbalance_ancient_card or {}).suit or 'Spades'
        return { vars = { card.ability.extra.xmult, localize(suit, 'suits_singular'), colours = { G.C.SUITS[suit] } } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(G.GAME.current_round.bbalance_ancient_card.suit) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
 })