local function lose_up_to(dollars)
    local lose = math.max(0, math.min(G.GAME.dollars - G.GAME.bankrupt_at, dollars))
    if lose ~= 0 then
        ease_dollars(-lose, true)
    end
end

SMODS.Consumable:take_ownership('c_wraith', {
    config = { extra = { pay = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.pay } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event {
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound 'timpani'
                local new_card = create_card('Joker', G.jokers, nil, 0.99, nil, nil, nil, 'wra')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                card:juice_up(0.3, 0.5)
                lose_up_to(card.ability.extra.pay)
                return true
            end
        })
        delay(0.6)
    end
})