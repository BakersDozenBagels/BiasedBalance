SMODS.Joker {
    atlas = "Joker",
    key = "Spare_Joker",
    pos = {
        x = 11,
        y = 4
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            chips = 125,
            a_chips = 35,
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.chips,
                card.ability.extra.a_chips
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local unscored_count = (#context.full_hand - #context.scoring_hand)
            if unscored_count >= 1 then
                return {
                    chips = card.ability.extra.chips + (unscored_count - 1) * card.ability.extra.a_chips
                }
            end
        end
    end,
}