SMODS.Joker:take_ownership("hit_the_road", {
    rarity = 2,
    cost = 7,
    config = { 
        extra = { 
            xmult_gain = 0.25, 
            xmult = 1 
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
        if context.discard and not context.blueprint and not context.other_card.debuff then
            if context.other_card:get_id() == 11 or context.other_card:get_id() == 12 or context.other_card:get_id() == 13 then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                colour = G.C.RED
            }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.xmult = 1
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
})