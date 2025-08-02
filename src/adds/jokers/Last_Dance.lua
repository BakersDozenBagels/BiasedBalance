SMODS.Joker {
    atlas = "Joker",
    key = "Last_Dance",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            repetitions = 1 
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.repetitions
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and
        (context.other_card == context.scoring_hand[4] or context.other_card == context.scoring_hand[5]) then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end,
}