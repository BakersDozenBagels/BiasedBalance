SMODS.Joker {
    atlas = "Joker",
    key = "Gourmet",
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
            mult = 0,
            mult_gain = 8
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult_gain,
                card.ability.extra.mult
        } 
    }
    end,
    calculate = function(self, card, context)

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}