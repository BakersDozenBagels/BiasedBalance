SMODS.Joker {
    atlas = "Joker",
    key = "Everhungry_Joker",
    pos = {
        x = 2,
        y = 1
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
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
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_gain } }
            }
        end
        if context.joker_main then 
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}