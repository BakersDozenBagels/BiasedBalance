local function juice_flip(used_tarot)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true
        end
    }))
    for i = 1, #G.hand.cards do
        local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                G.hand.cards[i]:flip(); play_sound('card1', percent); G.hand.cards[i]:juice_up(0.3, 0.3); return true
            end
        }))
    end
end
SMODS.Consumable:take_ownership('c_sigil', {
    config = { extra = { pay = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.pay } }
    end,
    can_use = function(self, card)
        return #G.hand.highlighted == 1
    end,
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        juice_flip(used_tarot)
        local _suit = G.hand.highlighted[1].base.suit
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event {
                func = function()
                    local _card = G.hand.cards[i]
                    assert(SMODS.change_base(_card, _suit))
                    return true
                end
            })
        end
        G.E_MANAGER:add_event(Event {
            func = function()
                lose_up_to(card.ability.extra.pay)
                return true
            end
        })
        for i = 1, #G.hand.cards do
            local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event {
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.cards[i]:juice_up(0.3, 0.3); return true
                end
            })
        end
        delay(0.5)
    end
})