SMODS.Joker {
    atlas = "Joker",
    key = "Hypernova",
    pos = {
        x = 3,
        y = 1
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            mult = 3
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult
        } 
    }
    end,
    calculate = function(self, card, context)
       if context.joker_main then
            return {
                mult = ((G.GAME.hands[context.scoring_name].level) * card.ability.extra.mult)
            }
        end
    end,
}