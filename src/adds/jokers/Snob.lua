local function count_snob()
    if not G.playing_cards then return 0 end

    local bad = {
        [2] = 1,
        [3] = 1,
        [4] = 1,
        [5] = 1,
        [6] = 1,
    }

    local count = 0
    for k, v in pairs(G.playing_cards) do
        count = count + (bad[v:get_id()] or 0)
    end
    return count
end

SMODS.Joker {
    atlas = "Joker",
    key = "Snob",
    pos = {
        x = 0,
        y = 3
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 3.25, d_x_mult = 0.1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.d_x_mult, card.ability.extra.x_mult - card.ability.extra.d_x_mult * count_snob() } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual then
            local val = card.ability.extra.x_mult - card.ability.extra.d_x_mult * count_snob()
            if val > 1 then
                return {
                    x_mult = val
                }
            end
        end
    end
}
