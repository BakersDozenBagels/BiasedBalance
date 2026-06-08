SMODS.Joker {
    atlas = "Joker",
    key = "Skipper",
    pos = {
        x = 10,
        y = 6
    },
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for _, v in pairs(G.GAME.round_resets.blind_states) do
                if v == 'Skipped' then
                    return { x_mult = card.ability.extra.xmult }
                end
            end
        end
    end
}