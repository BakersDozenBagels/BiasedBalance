SMODS.Joker {
    atlas = "Joker",
    key = "Eldritch_Joker",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            xmult = 1,
            xmult_gain = .05,
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.xmult_gain,
                card.ability.extra.xmult
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round then
           card.ability.extra.xmult = 0 
           return {
                message = "Reset!",
                colour = G.C.FILTER
           }
        end
    end
}