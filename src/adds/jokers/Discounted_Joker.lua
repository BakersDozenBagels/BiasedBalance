SMODS.Joker {
    atlas = "Joker",
    key = "Discounted_Joker",
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
            shop_spend = 20
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.shop_spend
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.end_of_round then 
            card.ability.extra.shop_spend = 20
        end
        
    end
}