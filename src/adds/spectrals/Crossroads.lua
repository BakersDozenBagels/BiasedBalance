SMODS.Consumable {
    key = 'Crossroads',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 3,
        y = 0
    },
    cost = 4,
    config = { extra = { pay = 10, cards = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards, card.ability.extra.pay } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.extra.cards
    end,
    use = function(self, card, area, copier)
        if not self:can_use(card) then return end

        local conv = {}
        for _, v in pairs(G.hand.highlighted) do
            conv[#conv + 1] = v
        end

        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                BiasedBalance.lose_up_to(card.ability.extra.pay)
                return true
            end
        }))

        for _, v in ipairs(conv) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local edition = poll_edition('aura', nil, nil, true, {
                        { name = 'e_foil',       weight = 25 },
                        { name = 'e_holo',       weight = 35 },
                        { name = 'e_negative',   weight = 25 },
                        { name = 'e_polychrome', weight = 15 },
                    })
                    v:set_edition(edition, true)
                    return true
                end
            }))
        end

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}