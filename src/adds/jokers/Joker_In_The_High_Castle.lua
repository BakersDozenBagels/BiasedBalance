SMODS.Joker {
    atlas = "Joker",
    key = "Joker_In_The_High_Castle",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            repetitions = 2
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
        if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}