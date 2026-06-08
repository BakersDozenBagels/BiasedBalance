SMODS.Consumable {
    key = 'Mania',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 2,
        y = 1
    },
    cost = 4,
    config = { extra = { pay = 10, cards = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards, card.ability.extra.pay } }
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,
    use = function(self, card, area, copier)
        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(card.ability.extra.cards,
                G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Joker',
                            rarity = 'Uncommon',
                            key_append = 'mania'
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                BiasedBalance.lose_up_to(card.ability.extra.pay)
                return true
            end
        }))
        end
    end
}