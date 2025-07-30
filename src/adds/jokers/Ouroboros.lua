SMODS.Joker {
    atlas = "Joker",
    key = "Ouroboros",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = { 
        extra = { 
            xmult = 1,
            xmult_gain = .25,
            tracker = 8
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.xmult_gain,
                card.ability.extra.xmult,
                card.ability.extra.tracker
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 4 or context.other_card:get_id() == 8 then
                card.ability.extra.tracker = card.ability.extra.tracker - 1
                if card.ability.extra.tracker == 0 then
                    card.ability.extra.tracker = 8
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}