SMODS.Joker:take_ownership("green_joker", {
    config = {
        extra = {
            mult = 0,
            mult_gain = 1,
        }
    },
    perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult_gain,
                card.ability.extra.mult,
        } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            if #context.scoring_hand < 4 then
                card.ability.extra.mult = math.max(0, card.ability.extra.mult - card.ability.extra.mult_gain)
                return {
                    message = localize { type = 'variable', key = 'a_mult_minus', vars = { card.ability.extra.mult_gain } },
                    colour = G.C.RED
                }
            else
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_gain } }
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
})