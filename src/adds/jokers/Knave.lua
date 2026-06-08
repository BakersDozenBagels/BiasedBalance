SMODS.Joker {
    atlas = "Joker",
    key = "Knave",
    pos = {
        x = 1,
        y = 5
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            chips = 100,
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.chips
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand 
        and not context.end_of_round and context.other_card:get_id() == 11 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}