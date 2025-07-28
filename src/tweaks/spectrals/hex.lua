SMODS.Consumable:take_ownership('c_hex', {
    config = { extra = { pay = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.pay } }
    end,
    use = function(self, card, area, copier)
        local temp_pool = card.eligible_editionless_jokers
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(temp_pool, pseudoseed 'hex')
                eligible_card:set_edition({ polychrome = true }, true)
                check_for_unlock { type = 'have_edition' }
                card:juice_up(0.3, 0.5)
                lose_up_to(card.ability.extra.pay)
                return true
            end
        }))
        delay(0.6)
    end
})