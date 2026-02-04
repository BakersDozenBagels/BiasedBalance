SMODS.Joker {
    atlas = "Joker",
    key = "Subversive_Joker",
    pos = {
        x = 5,
        y = 1
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            mult = 16,
            chips = 100,
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
        return {
            mult = card.ability.extra.mult * math.floor(G.GAME.chips / card.ability.extra.chips)
        }
        end
    end,
}