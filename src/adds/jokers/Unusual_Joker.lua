SMODS.Joker {
    key = "Unusual_Joker",
    atlas = "Joker",
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    pos = { x = 5, y = 4 },
    config = { extra = { xmult = 1, xmult_mod = 0.5 } },
    loc_vars = function(self, info_queue, card)
        local common_jokers = {}
        if G.jokers then
            for _, c in ipairs(G.jokers.cards) do 
                if c.config.center.rarity == 1 then
                    common_jokers[#common_jokers + 1] = c
                end
            end
        end
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult + card.ability.extra.xmult_mod * #common_jokers } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local common_jokers = {}
            for _, c in ipairs(G.jokers.cards) do 
                if c.config.center.rarity == 1 then
                    common_jokers[#common_jokers + 1] = c
                end
            end
            return {
                xmult = card.ability.extra.xmult + 0.5 * #common_jokers
            }
        end
    end,
}
