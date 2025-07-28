local seanced = {}
SMODS.Joker:take_ownership("seance", {
    config = { extra = { odds = 2, poker_hand = 'Straight Flush' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and not context.game_over then
            local found = {}
            for _, v in ipairs(G.consumeables.cards) do
                if (v.config.center.set == "Tarot") and not seanced[v] then
                    found[#found + 1] = v
                end
            end
            if #found == 0 then return end
            -- if #found == 0 or pseudorandom(pseudoseed('seance')) > G.GAME.probabilities.normal / card.ability.extra.odds then return end

            local card = pseudorandom_element(found, pseudoseed('seance2'))

            seanced[card] = true
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                blocking = false,
                delay = 0.0,
                func = (function()
                    card:start_dissolve()
                    local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'sea')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    seanced = {}
                    return true
                end)
            }))
            return {
                message = localize('k_plus_spectral'),
                colour = G.C.SECONDARY_SET.Spectral
            }
        end
        if context.joker_main then return {} end
    end
})