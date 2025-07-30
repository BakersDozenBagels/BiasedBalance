SMODS.Joker {
    atlas = "Joker",
    key = "Everhungry_Joker",
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
            mult = 0,
            mult_gain = 1
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
        if context.using_consumeable then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = "+1 Mult!",
                colour = G.C.MULT
            }
        end
        if context.joker_main then 
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}