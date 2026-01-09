local function count_alien(level)
    if not G.GAME or not G.GAME.hands then return 0 end

    local count = 0
    for k, v in pairs(G.GAME.hands) do
        if v.visible and v.level or 0 >= level then
            count = count + 1
        end
    end
    return count
end

SMODS.Joker {
    atlas = "Joker",
    key = "AlienJoker",
    pos = {
        x = 1,
        y = 3
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 0.2, level = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.level, 1 + card.ability.extra.x_mult * count_alien(card.ability.extra.level) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual then
            local val = 1 + card.ability.extra.x_mult * count_alien(card.ability.extra.level)
            if val > 1 then
                return {
                    x_mult = val
                }
            end
        end
    end
}