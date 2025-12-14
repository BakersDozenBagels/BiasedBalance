SMODS.Joker {
    key = "Ballerina",
    atlas = "Joker",
    pos = {
        x = 8,
        y = 0
    },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            size = 5,
            money = 3,
            first_hand = nil,
            second_hand = nil,
            third_hand = nil
        }
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.size,
                card.ability.extra.money
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            if #context.scoring_hand >= card.ability.extra.size then
                local total_hands = 1
                -- Check for first hand
                if not card.ability.extra.first_hand then
                    card.ability.extra.first_hand = context.scoring_name
                    return {
                        message = (total_hands .. '/3'),
                        colour = G.C.FILTER
                    }
                end
                -- Check for second hand
                total_hands = total_hands + 1
                if not card.ability.extra.second_hand then
                    -- Reset if First = Second
                    if card.ability.extra.first_hand == context.scoring_name then
                        card.ability.extra.first_hand = nil
                        card.ability.extra.second_hand = nil
                        card.ability.extra.third_hand = nil
                        return {
                            message = localize('k_reset'),
                            colour = G.C.RED
                        }
                    end
                    -- Set Second Hand
                    card.ability.extra.second_hand = context.scoring_name
                    return {
                        message = (total_hands .. '/3'),
                        colour = G.C.FILTER
                    }
                end
                -- Check for third hand
                if not card.ability.extra.third_hand then
                    -- Reset if Second = Third
                    if card.ability.extra.second_hand == context.scoring_name then
                        card.ability.extra.first_hand = nil
                        card.ability.extra.second_hand = nil
                        card.ability.extra.third_hand = nil
                        return {
                            message = localize('k_reset'),
                            colour = G.C.RED
                        }
                    end
                    -- Set Third Hand
                    card.ability.extra.third_hand = context.scoring_name
                        local r = pseudorandom('j_biasedBalance_Ballerina')
                        local hands = {
                            card.ability.extra.first_hand,
                            card.ability.extra.second_hand,
                            card.ability.extra.third_hand
                        }
                        local idx = math.floor(r * #hands) + 1
                        local hand = hands[idx]

                        SMODS.smart_level_up_hand(card, hand, false, 1)

                        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
                        card.ability.extra.first_hand = nil
                        card.ability.extra.second_hand = nil
                        card.ability.extra.third_hand = nil
                        return {
                            dollars = card.ability.extra.money,
                            func = function() -- This is for timing purposes, it runs after the dollar manipulation
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.GAME.dollar_buffer = 0
                                        return true
                                    end
                                }))
                            end
                        }
                end

            else
                -- No 5 card hand played
                card.ability.extra.first_hand = nil
                card.ability.extra.second_hand = nil
                card.ability.extra.third_hand = nil
                return {
                            message = localize('k_reset'),
                            colour = G.C.RED
                        }
            end
        end
    end
}