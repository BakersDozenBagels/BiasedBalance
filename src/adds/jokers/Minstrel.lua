SMODS.Joker {
    atlas = "Joker",
    key = "Minstrel",
    pos = {
        x = 11,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { d_size = 2, extra = { discard_size = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.d_size, card.ability.extra.discard_size } }
    end
}