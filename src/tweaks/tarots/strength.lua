SMODS.Consumable:take_ownership('c_strength', {
    config = {
        mod_conv = 'up_rank',
        max_highlighted = 3,
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, card.ability.extra.uses, card.ability.extra.uses == 1 and "" or "s" } }
    end,
})