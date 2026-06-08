SMODS.Joker {
    atlas = "Joker",
    key = "Mystery_Box",
    pos = {
        x = 0,
        y = 2
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    config = { 
        extra = { 
            creates = 2
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
            card.ability.extra.creates
            } 
    }
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.destroy_cards(card, nil, nil, true)
                return true
                end}))
            if #G.jokers.cards + G.GAME.joker_buffer <= G.jokers.config.card_limit then
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                if pseudorandom('LEGENDARYCHANCE!!') <= 0.01 then
                    G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        SMODS.add_card {
                            set = 'Joker',
                            legendary = true,
                            key_append = 'Mystery_Box'
                        }
                        G.GAME.joker_buffer = 0
                        return true
                    end
                }))
                else
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            SMODS.add_card {
                                set = 'Joker',
                                rarity = 'Rare',
                                key_append = 'Mystery_Box'
                            }
                            G.GAME.joker_buffer = 0
                            return true
                        end
                    }))
            end
            end
            if #G.consumeables.cards < G.consumeables.config.card_limit then
            local cards_to_create = math.min(card.ability.extra.creates, G.consumeables.config.card_limit - (#G.consumeables.cards))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    for _ = 1, cards_to_create do
                        SMODS.add_card {
                                set = 'Tarot',
                                key_append = 'Mystery_Box',
                            }
                    end
                    return true
                end
                }))
                return {
                        message = localize('k_mysteryBox_open')
                    }
            end
        end
    end,
}