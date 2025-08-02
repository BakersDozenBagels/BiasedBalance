SMODS.Joker:take_ownership("ride_the_bus", { 
    rarity = 1,  
    config = {
        extra = {
            mult = 0,
            mult_gain = 1,
            mult_lose = 3
        }
    },
     loc_vars = function(self, info_queue, card)
        return { 
            vars = {  
                card.ability.extra.mult_gain,
                card.ability.extra.mult_lose,
                card.ability.extra.mult,
            } }
    end,
    calculate = function(self, card, context)
        if context.before then
            for i, v in ipairs(context.scoring_hand) do
                if v:get_id() == 11 or v:get_id() == 12 or v:get_id() == 13 then
                    card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_lose
                    if card.ability.extra.mult < 0 then
                        card.ability.extra.mult = 0
                    end
                else
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
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