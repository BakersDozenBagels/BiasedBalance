SMODS.Joker {
    atlas = "Joker",
    key = "Leprechaun",
    pos = {
        x = 4,
        y = 3
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            x_mult = 2.5,
            money = 75
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual and G.GAME.dollars + (G.GAME.dollar_buffer or 0) >= card.ability.extra.money then
            return { x_mult = card.ability.extra.x_mult }
        end
    end
}