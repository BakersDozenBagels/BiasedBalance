
SMODS.Joker {
    atlas = "Joker",
    key = "Star_Fall",
    pos = {
        x = 9,
        y = 5
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { chips = 8 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips * (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0) } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Planet" then
            return {
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips * G.GAME.consumeable_usage_total.planet } },
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips *
                    (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0)
            }
        end
    end
}