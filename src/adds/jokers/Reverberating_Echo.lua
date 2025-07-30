SMODS.Joker {
    atlas = "Joker",
    key = "Reverberating_Echo",
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
            xmult = 1.1
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
        if context.individual and context.cardarea == G.play then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}