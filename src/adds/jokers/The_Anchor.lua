SMODS.Joker {
    atlas = "Joker",
    key = "Anchor",
    pos = {
        x = 5,
        y = 3
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            x_mult = 3,
            chips = 400
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual and hand_chips >= card.ability.extra.chips then
            return { x_mult = card.ability.extra.x_mult }
        end
    end
}