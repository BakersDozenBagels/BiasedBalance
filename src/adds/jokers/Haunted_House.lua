SMODS.Joker {
    atlas = "Joker",
    key = "Haunted_House",
    pos = {
        x = 0,
        y = 0
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
                    local chosen_spectral = pseudorandom_element(BiasedBalance.Spectrals, pseudoseed('choice'))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            local spectral = create_card("Spectral", G.consumeables, nil, nil, nil, nil, 'c_'.. chosen_spectral)
                            spectral:add_to_deck()
                            G.consumeables:emplace(spectral)
                            return true
                        end
                }))
            else
                return {
                    message = "Nope!",
                    colour = G.C.FILTER
                }
                end
            end
        end
    end
}