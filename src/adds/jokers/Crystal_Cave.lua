SMODS.Joker {
    atlas = "Joker",
    key = "Crystal_Cave",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            xmult = 1.15,
            xmult_gain = .15
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
        if context.cardarea == G.play and context.individual then
            if context.other_card:is_suit("Hearts") or context.other_card:is_suit("Diamonds") then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round then
            card.ability.extra.xmult = 1.15
            return {
                message = "Reset!",
                colour = G.C.FILTER
            }
        end
    end
}