SMODS.Consumable {
    key = 'Awakening',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 4,
        y = 0
    },
    cost = 4,
    can_use = function(self, card) return true end,
    use = function(self, card, area, copier)
        G.GAME.biasedBalance_awakening = (G.GAME.biasedBalance_awakening or 0) + 1
    end
}