SMODS.Consumable {
    key = 'Sacrifice',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 0,
        y = 1
    },
    cost = 4,
    config = { extra = { dollars = 30 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards >= 1 and not G.jokers.cards[1].ability.eternal
    end,
    use = function(self, card, area, copier)
        if not self:can_use(card) then return end

        local slice = G.jokers.cards[1]
        G.E_MANAGER:add_event(Event {
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                slice:start_dissolve()
                ease_dollars(card.ability.extra.dollars)
                return true
            end
        })
    end
}