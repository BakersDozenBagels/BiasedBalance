SMODS.Joker {
    atlas = "Joker",
    key = "Solitude",
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
            xmult = 2 
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.xmult
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if not next(context.poker_hands['Pair']) then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
}