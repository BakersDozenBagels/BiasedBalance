SMODS.Consumable {
    key = 'Transmutation',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 4,
        y = 0
    },
    config = {
        max_highlighted = 2,
        extra = {
            uses = 2
        }
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.uses,
            }
        }  
    end,
    can_use = function(self)
        return #G.hand.highlighted == self.config.max_highlighted
    end,
    use = function(self, card, area)
        G.hand:change_size(1)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
        ease_discard(1)
    end
}
