SMODS.Joker {
    atlas = "Joker",
    key = "Downwards_Spiral",
    pos = {
        x = 1,
        y = 8
    },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = { 
        extra = { 
            mult = 20,
            chips = 10
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult,
                card.ability.extra.chips
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.joker_main then 
        local chips = (G.GAME.hands[context.scoring_name].level) * card.ability.extra.chips
        local current_hand_chips = hand_chips
        if chips >= current_hand_chips - 5 then
            chips = current_hand_chips - 5
        end
        
            return {
                mult = card.ability.extra.mult,
                chips = -chips
            }
        end
    end
}