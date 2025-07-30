SMODS.Joker {
    atlas = "Joker",
    key = "Chisel",
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
           stone_trans = 0
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 

        } 
    }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then 
            card.ability.extra.stone_trans = card.ability.extra.stone_trans + 1
        end
        if context.joker_main and context.cardarea == G.hand then
            if context.other_card then
                context.other_card[1]:set_ability("m_stone", true)
            end
        end
    end
}