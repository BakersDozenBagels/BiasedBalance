SMODS.Voucher:take_ownership('planet_tycoon', {
    config = {
            extra = 12/4,
            planet_create = 5
        },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.planet_create,
            }
        }  
        end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Planet' then
            card.ability.planet_create = card.ability.planet_create - 1
        if card.ability.planet_create == 0 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then 
            card.ability.planet_create = 5
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = 'Planet',
                            key_append = 'planetTycoon' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
        end
    end
end
})