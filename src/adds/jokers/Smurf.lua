SMODS.Joker {
    atlas = "Joker",
    key = "Smurf",
    pos = {
        x = 11,
        y = 0
    },
    rarity = 1,
    cost = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = 4 },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}