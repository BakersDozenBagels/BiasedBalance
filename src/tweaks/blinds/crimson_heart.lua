SMODS.Blind:take_ownership("final_heart", { 
    dollars = 8,
    mult = 2,
    pos = { x = 0, y = 25 },
    boss = { showdown = true },
    boss_colour = HEX("ac3232"),
    loc_vars = function(self)
        local plural = localize('k_joker')
        local num = 1
        if G.GAME.Biased_Balance.jokers_held_at_ante and G.GAME.Biased_Balance.jokers_held_at_ante >= 7 then
            plural = localize('b_jokers')
            num = 1 + math.floor((G.GAME.Biased_Balance.jokers_held_at_ante - 5) / 2)
        end
        return { vars = { num, plural } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 1, localize('k_joker') } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area == G.jokers then
                if context.debuff_card.ability.crimson_heart_chosen then
                    return {
                        debuff = true
                    }
                end
            end
            if context.press_play and G.jokers.cards[1] then
                blind.triggered = true
                blind.prepped = true
            end
            if context.hand_drawn then
                if blind.prepped and G.jokers.cards[1] then
                    local prev_chosen_set = {}
                    local fallback_jokers = {}
                    local jokers = {}
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i].ability.crimson_heart_chosen then
                            prev_chosen_set[G.jokers.cards[i]] = true
                            G.jokers.cards[i].ability.crimson_heart_chosen = nil
                            if G.jokers.cards[i].debuff then SMODS.recalc_debuff(G.jokers.cards[i]) end
                        end
                    end
                    for i = 1, #G.jokers.cards do
                        if not G.jokers.cards[i].debuff then
                            if not prev_chosen_set[G.jokers.cards[i]] then
                                jokers[#jokers + 1] = G.jokers.cards[i]
                            end
                            table.insert(fallback_jokers, G.jokers.cards[i])
                        end
                    end
                    if #jokers == 0 then jokers = fallback_jokers end
                    local _selected = {}
                    local picks = math.floor((G.GAME.Biased_Balance.jokers_held_at_ante - 5) / 2)
                    for i = 1, picks do
                        if #jokers == 0 then break end
                        local _card = pseudorandom_element(jokers, 'bb_crimson_heart')
                        if not _card then break end
                        _selected[#_selected + 1] = _card

                        for j = #jokers, 1, -1 do
                            if jokers[j] == _card then
                                table.remove(jokers, j)
                                break
                            end
                        end
                    end
                    if #_selected > 0 then
                        for _, card in ipairs(_selected) do
                            card.ability.crimson_heart_chosen = true
                            SMODS.recalc_debuff(card)
                            card:juice_up()
                        end
                        blind:wiggle()
                    end
                end
            end
        end
        if context.hand_drawn then
            blind.prepped = nil
        end
    end,
    disable = function(self)
        for _, joker in ipairs(G.jokers.cards) do
            joker.ability.crimson_heart_chosen = nil
        end
    end,
    defeat = function(self)
        for _, joker in ipairs(G.jokers.cards) do
            joker.ability.crimson_heart_chosen = nil
        end
    end
})