SMODS.Joker {
    atlas = "Joker",
    key = "Haunted_House",
    pos = {
        x = 12,
        y = 4
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            spectral_suc = 2
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = {
                (G.GAME.probabilities.normal or 1), 
                card.ability.extra.spectral_suc
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.before then 
            if next(context.poker_hands['Full House']) then
                if (pseudorandom('Haunted_House_spectral_suc') < G.GAME.probabilities.normal / card.ability.extra.spectral_suc) then
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                SMODS.add_card {
                                    set = 'Spectral',
                                    key_append = 'Haunted_House' 
                                }
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                    }))
                    return {
                            message = localize('k_plus_spectral'),
                            colour = G.C.SECONDARY_SET.Spectral,
                        }
                    end
                end
            end
        end
    end
}