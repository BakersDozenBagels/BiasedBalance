
SMODS.Joker {
    atlas = "Joker",
    key = "Rhododendron",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 20, ranks = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.ranks } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local t = 0
            local ranks = {}
            for _, v in pairs(context.scoring_hand) do
                if not ranks[v.base.rank] then
                    ranks[v.base.rank] = true
                    t = t + 1
                end
            end
            if t >= card.ability.extra.ranks then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end
}