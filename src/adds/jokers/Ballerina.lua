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
    config = {},
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
        
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local checker = false 
            for i, v in ipairs(context.scoring_hand) do
                if #v == 5 then
                    checker = true
                end
            end
            local first_check = 0
            local second_check = 0
            local third_check = 0
            if checker then
                local first_hand = G.GAME.hands[context.scoring_name]
                first_check = first_check + 1
                if first_check == 1 then 
                    local second_hand = G.GAME.hands[context.scoring_name]
                    second_check = second_check + 1
                elseif second_check == 1 and not second_hand == first_hand then
                    local third_hand = G.GAME.hands[context.scoring_name]
                    third_check = third_check + 1
                elseif third_check == 1 and not second_hand == third_hand
                and not first_hand == third_hand then
                end
            end
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Practical_Perfectionist",
    pos = {
        x = 9,
        y = 0
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            money = 3,
            size = 5
        }
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.money 
        } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and #context.full_hand >= card.ability.extra.size then
            ease_dollars(card.ability.extra.money)
        return {
                message = "+$3!",
                colour = G.C.GOLD
                }
        end
    end
}