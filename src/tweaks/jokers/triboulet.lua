SMODS.Joker:take_ownership("triboulet", { 
    config = { extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            (context.other_card:get_id() == 12 or context.other_card:get_id() == 13) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
 })