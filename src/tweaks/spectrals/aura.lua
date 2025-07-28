SMODS.Consumable:take_ownership('c_aura', {
    use = function(self, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local over = false
                local edition = poll_edition('aura', nil, nil, true, {
                    { name = 'e_foil',       weight = 30 },
                    { name = 'e_holo',       weight = 22.5 },
                    { name = 'e_negative',   weight = 32.5 },
                    { name = 'e_polychrome', weight = 15 },
                })
                local aura_card = G.hand.highlighted[1]
                aura_card:set_edition(edition, true)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end
})