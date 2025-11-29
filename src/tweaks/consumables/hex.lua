SMODS.Consumable:take_ownership('c_hex', {
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        return { vars = { } }
    end,
    use = function(self, card, area, copier)
        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(editionless_jokers, 'hex')
                eligible_card:set_edition({ polychrome = true })

                local _first_dissolve = nil
                for _, joker in pairs(G.jokers.cards) do
                    if (not joker.ability.eternal) then
                        joker:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                        break
                    end
                end

                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true)) and #G.jokers.cards > 1
    end
})