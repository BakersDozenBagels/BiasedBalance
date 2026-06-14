local function count_alien(level)
    if not G.GAME or not G.GAME.hands then return 0 end

    local thresh = level or 2
    local count = 0
    for _, v in pairs(G.GAME.consumeable_usage) do
        if v.set == 'Planet' and v.count >= thresh then
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
    config = { extra = { x_mult = 0.2, level = 2 } },
    loc_vars = function(self, info_queue, card)
        local planets_used = 0
        for k, v in pairs(G.GAME.consumeable_usage) do
            if v.set == 'Planet' and v.count >= (card.ability.extra.level or 1) then
                planets_used = planets_used + 1
            end
        end
        return { vars = { card.ability.extra.x_mult, 1 + card.ability.extra.x_mult * planets_used, card.ability.extra.level } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual then
            local planets_used = 0
            for k, v in pairs(G.GAME.consumeable_usage) do
                if v.set == 'Planet' and v.count >= (card.ability.extra.level or 1) then
                    planets_used = planets_used + 1
                end
            end
            local val = 1 + card.ability.extra.x_mult * planets_used
            if val > 1 then
                return {
                    x_mult = val
                }
            end
        end
    end
}