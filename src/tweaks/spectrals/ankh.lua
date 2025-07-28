SMODS.Consumable:take_ownership('c_ankh', {
    loc_vars = function(self, info_queue, card)
        local main_end = nil
        if G.jokers and G.jokers.cards then
            for k, v in ipairs(G.jokers.cards) do
                if (v.edition and v.edition.negative) and (G.localization.descriptions.Other.remove_negative) then
                    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
                    main_end = {}
                    localize { type = 'other', key = 'remove_negative', nodes = main_end, vars = {} }
                    main_end = main_end[1]
                    break
                end
            end
        end
        return { main_end = main_end }
    end,
    use = function(self, card, area, copier)
        local deletable_jokers = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.eternal then deletable_jokers[#deletable_jokers + 1] = v end
        end
        local chosen_joker = G.jokers.cards[1]
        local _first_dissolve = nil
        G.E_MANAGER:add_event(Event {
            trigger = 'before',
            delay = 0.75,
            func = function()
                for k, v in pairs(deletable_jokers) do
                    if v ~= chosen_joker then
                        v:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                end
                return true
            end
        })
        G.E_MANAGER:add_event(Event {
            trigger = 'before',
            delay = 0.4,
            func = function()
                local card = copy_card(chosen_joker, nil, nil, nil,
                    chosen_joker.edition and chosen_joker.edition.negative)
                card:start_materialize()
                card:add_to_deck()
                if card.edition and card.edition.negative then
                    card:set_edition(nil, true)
                end
                G.jokers:emplace(card)
                return true
            end
        })
    end
})