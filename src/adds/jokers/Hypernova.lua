SMODS.Joker {
    atlas = "Joker",
    key = "Hypernova",
    pos = {
        x = 1,
        y = 7
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 

        } 
    }
    end,
    calculate = function(self, card, context)
       if context.joker_main then
            return {
                mult = ((G.GAME.hands[context.scoring_name].played) * 3)
            }
        end
    end,
}