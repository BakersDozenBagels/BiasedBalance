SMODS.Joker {
    atlas = "Joker",
    key = "Caviar",
    pos = {
        x = 3,
        y = 0
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args) 
        return not G.GAME.selected_back.effect.center.key == 'b_biasedBalance_Pink'
    end,
}