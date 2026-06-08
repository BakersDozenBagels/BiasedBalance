SMODS.Joker {
    atlas = "Joker",
    key = "Parachutist",
    pos = {
        x = 2,
        y = 8
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        card_limit = 1,
        extra = { 
            mult = 8,
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult,
                card.ability.card_limit
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.joker_main then 
            return {
                mult = card.ability.extra.mult,
            }
        end
    end
}