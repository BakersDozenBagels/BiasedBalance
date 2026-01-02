SMODS.Joker {
    atlas = "Joker",
    key = "Shy_Joker",
    pos = {
        x = 5,
        y = 2
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 12 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}