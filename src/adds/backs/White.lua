SMODS.Back {
    key = "White",
    name = "White",
    atlas = "Backs",
    pos = {
        x = 0,
        y = 0
    },
    calculate = function(self, card, context)
        if ((context.setting_blind and not G.GAME.blind.boss) or context.skip_blind) and
        #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then 
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card {
                        set = 'Joker',
                        rarity = 'Common',
                        key_append = 'whiteDeck' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                    }
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.BLUE,
            }
        end
    end
}
