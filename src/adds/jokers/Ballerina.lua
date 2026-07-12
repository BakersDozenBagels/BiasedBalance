local function has_unique_values(values)
    local seen = {}
    for _, value in ipairs(values) do
        if seen[value] then
            return false
        end
        seen[value] = true
    end
    return true
end

SMODS.Joker {
    key = "Ballerina",
    atlas = "Joker",
    pos = {
        x = 8,
        y = 0
    },
    rarity = 1,
    cost = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            money = 8,
            num_hands = 4,
            current_hands = {}
        }
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.money,
                card.ability.extra.num_hands,
                card.ability.extra.current_hands
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            table.insert(card.ability.extra.current_hands, context.scoring_name)

            local current_hands = card.ability.extra.current_hands
            local unique_values = has_unique_values(current_hands)

            if unique_values and #current_hands >= card.ability.extra.num_hands then
                SMODS.calculate_effect {
                    dollars = card.ability.extra.money,
                    card = card,
                }
                local r = pseudorandom('j_biasedBalance_Ballerina')
                local idx = math.floor(r * #card.ability.extra.current_hands) + 1
                local hand = card.ability.extra.current_hands[idx]

                SMODS.smart_level_up_hand(card, hand, false, 1)
                card.ability.extra.current_hands = {}
                return {
                            message = localize('k_reset'),
                            colour = G.C.RED
                        }
            elseif not unique_values then
                card.ability.extra.current_hands = {}
                return {
                            message = localize('k_reset'),
                            colour = G.C.RED
                        }
            else
                return {
                        message = (#card.ability.extra.current_hands .. '/' .. card.ability.extra.num_hands),
                        colour = G.C.FILTER
                    }
            end
        end
    end
}