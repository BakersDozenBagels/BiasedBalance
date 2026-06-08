SMODS.Back {
    key = 'Teal',
    atlas = 'Backs',
    pos = {
        x = 3,
        y = 0
    },
    config = {
    },
    calculate = function(self, card, context) 
    if context.ending_shop and
        #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then 
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card {
                        set = 'Tarot',
                        key_append = 'tealDeck' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                    }
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return {
                message = localize('k_plus_tarot'),
                colour = G.C.PURPLE,
            }
        end
    end
}