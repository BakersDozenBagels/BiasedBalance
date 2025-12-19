SMODS.Joker {
    atlas = "Joker",
    key = "Conspiracy",
    pos = {
        x = 6,
        y = 1
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    config = { 
        extra = { 
            rounds = 1,
            current = 0
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.rounds,
                card.ability.extra.current
            }
    }
    end,
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.extra.current >= card.ability.extra.rounds) and not context.blueprint then
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+1' })
            delay(1.3)
            for poker_hand_key, _ in pairs(G.GAME.hands) do
                level_up_hand(card, poker_hand_key, true)
            end
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                { mult = 0, chips = 0, handname = '', level = '' })
                
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.add_card {
                                    set = 'Spectral',
                                    key_append = 'conspiracy_spectral'
                                }
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                        SMODS.calculate_effect({ message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral, },
                            context.blueprint_card or card)
                        return true
                    end)
                }))
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.current = card.ability.extra.current + 1
            if card.ability.extra.current == card.ability.extra.rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.current < card.ability.extra.rounds) and
                    (card.ability.extra.current .. '/' .. card.ability.extra.rounds) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end,
}