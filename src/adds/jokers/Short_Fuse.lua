SMODS.Joker {
    atlas = "Joker",
    key = "Short_Fuse",
    pos = {
        x = 7,
        y = 1
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {
        hand_active = true,
    } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    pools = {
        Utility = true
    },
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            card.ability.extra.hand_active = true
        end
        if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
            return {
                repetitions = 1
            }
        end
        if context.repetition and context.cardarea == G.hand and (context.card_effects[1] or #context.card_effects > 1) and card.ability.extra.hand_active then
            card.ability.extra.hand_active = false
            return {
                repetitions = 1
            }
        end
        if context.final_scoring_step then
            card.ability.extra.hand_active = true
        end
    end,
}