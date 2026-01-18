SMODS.Joker {
    atlas = "Joker",
    key = "End_Of_Days",
    pos = {
        x = 4,
        y = 4
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
            
        } 
    }
    end,
    calculate = function(self, card, context)
         if context.end_of_round and G.GAME.current_round.hands_left == 0  and context.game_over == false and context.main_eval then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card {
                                set = 'Spectral',
                                key_append = 'endofdays'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    
                    return {
                        message = localize('k_plus_spectral'),
                        colour = G.C.SECONDARY_SET.Spectral,
                    }
                end
        end
    end
}