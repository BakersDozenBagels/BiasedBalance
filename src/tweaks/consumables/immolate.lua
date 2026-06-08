SMODS.Consumable:take_ownership('c_immolate', {
    config = { extra = { select = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.select } }
    end,
    can_use = function(self, card)
        return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.extra.select
    end,
    use = function(self, card, area, copier)
        local destroyed_cards = {}
        for i = #G.hand.highlighted, 1, -1 do
            destroyed_cards[#destroyed_cards + 1] = G.hand.highlighted[i]
        end
        G.E_MANAGER:add_event(Event {
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        })
        G.E_MANAGER:add_event(Event {
            trigger = 'after',
            delay = 0.2,
            func = function()
                for i = #G.hand.highlighted, 1, -1 do
                    local card = G.hand.highlighted[i]
                    if SMODS.shatters(card) then
                        card:shatter()
                    else
                        card:start_dissolve(nil, i == #G.hand.highlighted)
                    end
                end
                return true
            end
        })
        delay(0.3)
        SMODS.calculate_context { remove_playing_cards = true, removed = destroyed_cards }
    end
})