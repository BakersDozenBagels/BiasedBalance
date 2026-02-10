SMODS.Consumable {
    key = 'Transmutation',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 3,
        y = 1
    },
    cost = 4,
    config = { extra = { discard = 1, h_size = 1, money = 10 } },
    can_use = function(self, card)
        return true
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.discard,
                card.ability.extra.h_size,
                card.ability.extra.money
            }
        }  
    end,
    use = function(self, card, area)
        G.hand:change_size(card.ability.extra.h_size)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discard
        ease_discard(-card.ability.extra.discard)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                ease_dollars(card.ability.extra.money, true)
                return true
            end
        }))
        delay(0.6)
    end
}
