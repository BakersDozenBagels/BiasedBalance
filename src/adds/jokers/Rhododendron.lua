
SMODS.Joker {
    atlas = "Joker",
    key = "Rhododendron",
    pos = {
        x = 8,
        y = 5
    },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 24, ranks = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.ranks } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local t = 0
            local ranks = {}
            for _, v in pairs(context.scoring_hand) do
                if not ranks[v:get_id()] then
                    ranks[v:get_id()] = true
                    t = t + 1
                end
            end
            if t >= card.ability.extra.ranks then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}