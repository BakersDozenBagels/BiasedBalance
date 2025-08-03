SMODS.Joker:take_ownership("ride_the_bus", { 
    rarity = 1,  
    config = {
        multloss = { 
            mult = 3,
            mult_tracker = 0
        }, 
        extra = 1
    },
     loc_vars = function(self, info_queue, card)
        return { 
            vars = {  
                card.ability.extra,
                card.ability.multloss.mult,
                card.ability.multloss.mult_tracker
            } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local faces = false
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:is_face() then
                    faces = true
                    break
                end
            end
            if faces then
                card.ability.multloss.mult_tracker = math.max(card.ability.multloss.mult_tracker - card.ability.multloss.mult, 0)
            else
                card.ability.multloss.mult_tracker = card.ability.extra + card.ability.multloss.mult_tracker
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.multloss.mult_tracker
            }
        end
    end
})

