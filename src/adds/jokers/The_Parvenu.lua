SMODS.Joker {
    atlas = "Joker",
    key = "Parvenu",
    pos = {
        x = 9,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 2.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for k, v in pairs(context.scoring_hand) do
                if v:is_face() then return end
            end
            return { x_mult = card.ability.extra.xmult }
        end
    end
}