SMODS.Joker {
    atlas = "Joker",
    key = "Shameless_Profit",
    pos = {
        x = 9,
        y = 3
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            money = 3,
            money_add = 1
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.money + card.ability.extra.money_add * (G.GAME.skips or 0) , card.ability.extra.money_add
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MONEY
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.money + card.ability.extra.money_add * (G.GAME.skips or 0)
    end
}