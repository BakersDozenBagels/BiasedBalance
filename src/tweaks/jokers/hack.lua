SMODS.Joker:take_ownership("hack", {
    calculate = function(self, card, context)
        if context.repetition and (
                context.other_card:get_id() == 2 or 
                context.other_card:get_id() == 3 or 
                context.other_card:get_id() == 4 or 
                context.other_card:get_id() == 5 or
                context.other_card:get_id() == 6) then
                    return {
                        repetitions = 1,
                    }
        end
    end
})
