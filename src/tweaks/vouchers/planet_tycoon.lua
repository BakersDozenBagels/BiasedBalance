SMODS.Voucher:take_ownership('planet_tycoon', {
    config = {
        extra = {
            planet_create = 5
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.planet_create,
            }
        }  
        end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Planet' then
            card.ability.extra.planet_create = card.ability.extra.planet_create - 1
        if card.ability.extra.planet_create == 0 then 
            card.ability.extra.planet_create = 5
             G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local chosen_planet = pseudorandom_element(BiasedBalance.Planet_Pool, pseudoseed('choice'))
                        local planet = create_card("Planet", G.consumeables, nil, nil, nil, nil, 'c_'.. chosen_planet)
                        planet:add_to_deck()
                        G.consumeables:emplace(planet)
                        card:juice_up(0.3, 0.5)
                        return true
                end}))
        end
    end
end
})