SMODS.Joker {
    atlas = "Joker",
    key = "Stairs",
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
            xmult = 1,
            xmult_gain = .3
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
        if context.discard and context.discard_hand then
            if context.discard_hand.name == "Straight" then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}