SMODS.Joker {
    atlas = "Joker",
    key = "Singularity",
    pos = {
        x = 1,
        y = 7
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local unscored_count = (#context.full_hand - #context.scoring_hand)
            if unscored_count >= 1 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end 
        end
    end,
}