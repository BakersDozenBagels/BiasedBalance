SMODS.Joker:take_ownership("green_joker", {
    config = {
        extra = {
            mult = 0,
            mult_gain = 1,
            count = 0,
            hand_add = 0
        }
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult_gain,
                card.ability.extra.mult,
        } }
    end,
    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.count = 0
        end
        -- Count how many cards are in scoring hand
        if context.individual and context.cardarea == G.play then
            card.ability.extra.count = (card.ability.extra.count or 0) + 1
            if card.ability.extra.count >= 4 then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                card.ability.extra.hand_add = card.ability.extra.hand_add + card.ability.extra.mult_gain
            else 
                card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_gain
                 card.ability.extra.hand_add = card.ability.extra.hand_add - card.ability.extra.mult_gain
                if card.ability.extra.mult < 0 then
                    card.ability.extra.mult = 0
                end
            end
        end

        if context.joker_main then
            return {
                   mult = card.ability.extra.mult
                }
         end
end
})