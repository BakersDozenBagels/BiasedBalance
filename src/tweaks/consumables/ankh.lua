SMODS.Consumable:take_ownership('c_ankh', {
    use = function(self, card, area, copier)
        local deletable_jokers = {}
        for _, joker in pairs(G.jokers.cards) do
            if not joker.ability.eternal then deletable_jokers[#deletable_jokers + 1] = joker end
        end

        local chosen_joker = G.jokers.cards[1]
        local _first_dissolve = nil
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.75,
            func = function()
                for _, joker in pairs(deletable_jokers) do
                    if joker ~= chosen_joker then
                        joker:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                end
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.4,
            func = function()
                local copied_joker = copy_card(chosen_joker, nil, nil, nil,
                    chosen_joker.edition and chosen_joker.edition.negative)
                copied_joker:start_materialize()
                copied_joker:add_to_deck()
                if copied_joker.edition and copied_joker.edition.negative then
                    copied_joker:set_edition(nil, true)
                end
                G.jokers:emplace(copied_joker)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        for k, v in pairs(G.jokers.cards) do
            if v.ability.set == 'Joker' and G.jokers.config.card_limit > 1 then 
                return true
            end
        end
    end
})
--[[
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
        for _, joker in pairs(G.jokers.cards) do
            if not joker.ability.eternal then deletable_jokers[#deletable_jokers + 1] = joker end
        end

        local chosen_joker = G.jokers.cards[1]
        local _first_dissolve = nil
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.75,
            func = function()
                for _, joker in pairs(deletable_jokers) do
                    if joker ~= chosen_joker then
                        joker:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                end
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.4,
            func = function()
                local copied_joker = copy_card(chosen_joker, nil, nil, nil,
                    chosen_joker.edition and chosen_joker.edition.negative)
                copied_joker:start_materialize()
                copied_joker:add_to_deck()
                if copied_joker.edition and copied_joker.edition.negative then
                    copied_joker:set_edition(nil, true)
                end
                G.jokers:emplace(copied_joker)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards > 0 and #G.jokers.cards <= G.jokers.config.card_limit
    end]]