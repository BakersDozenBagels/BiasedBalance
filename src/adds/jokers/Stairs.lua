SMODS.Joker {
    atlas = "Joker",
    key = "Stairs",
    pos = {
        x = 11,
        y = 3
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = { 
        extra = { 
            xmult = 1,
            xmult_gain = .4,
            first_trigger = true
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.xmult_gain,
                card.ability.extra.xmult
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.pre_discard and not context.blueprint then
            local eval = evaluate_poker_hand(context.full_hand)
            if next(eval['Straight']) and card.ability.extra.first_trigger then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                card.ability.extra.first_trigger = false
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    colour = G.C.RED
                }
            end
        end
        if context.end_of_round then
            card.ability.extra.first_trigger = true
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}