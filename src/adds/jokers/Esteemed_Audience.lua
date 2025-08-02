SMODS.Joker {
    atlas = "Joker",
    key = "Esteemed_Audience",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = { 
        extra = { 
            mult = 0,
            mult_gain = 1,
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult_gain,
                card.ability.extra.mult
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 11 or context.other_card:get_id() == 12 or context.other_card:get_id() == 13 then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}