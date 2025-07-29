local function destroy_highlighted(used_tarot)
    local destroyed_cards = {}
    for _, v in ipairs(G.hand.highlighted) do
        destroyed_cards[#destroyed_cards + 1] = v
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            for i = #destroyed_cards, 1, -1 do
                local card = destroyed_cards[i]
                if card.ability.name == 'Glass Card' then
                    card:shatter()
                else
                    card:start_dissolve(nil, i ~= #destroyed_cards)
                end
            end
            return true
        end
    }))
    return destroyed_cards
end

SMODS.Consumable:take_ownership('c_incantation', {
    config = {
        extra = {
            destroy = 1,
            create = 4,
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.destroy, card.ability.extra.create } }
    end,
    can_use = function(self, card)
        return #G.hand.highlighted == card.ability.extra.destroy
    end,
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local destroyed_cards = destroy_highlighted(used_tarot)
        G.E_MANAGER:add_event(Event {
            trigger = 'after',
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, card.ability.extra.create do
                    local numbers = {}
                    for _, v in ipairs(SMODS.Rank.obj_buffer) do
                        local r = SMODS.Ranks[v]
                        if v ~= 'Ace' and not r.face then table.insert(numbers, r) end
                    end
                    local _suit, _rank =
                        pseudorandom_element(SMODS.Suits, pseudoseed('incantation_create')).card_key,
                        pseudorandom_element(numbers, pseudoseed('incantation_create')).card_key
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' and not v.overrides_base_rank then
                            cen_pool[#cen_pool + 1] = v
                        end
                    end
                    cards[i] = create_playing_card({
                        front = G.P_CARDS[_suit .. '_' .. _rank],
                        center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))
                    }, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
                end
                playing_card_joker_effects(cards)
                return true
            end
        })
        delay(0.3)
        SMODS.calculate_context { remove_playing_cards = true, removed = destroyed_cards }
    end
})