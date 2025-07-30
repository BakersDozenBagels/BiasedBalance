SMODS.Joker {
    atlas = "Joker",
    key = "Shameless_Profit",
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
            money = 3
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.money
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
            card.ability.extra.money = card.ability.extra.money + 1
            return {
                message = "+$1",
                colour = G.C.GOLD
            }
        end
        if context.end_of_round and context.cardarea == G.jokers then
            ease_dollars((G.GAME.skips or 0) *card.ability.extra.money)
            return {
                message = "+$" .. card.ability.extra.money,
                colour = G.C.GOLD
            }
        end
    end,
}