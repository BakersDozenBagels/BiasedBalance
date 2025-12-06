SMODS.Joker {
    atlas = "Joker",
    key = "Wallpaper",
    pos = {
        x = 7,
        y = 0
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            x_mult = 2,
            suits_allowed = 2
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.x_mult,
                card.ability.extra.suits_allowed
        } 
    }
    end,
    calculate = function(self, card, context)
        local suits = {}
        for k, _ in pairs(SMODS.Suits) do
            suits[k] = 0
        end

        if context.joker_main then
            for _, card in ipairs(G.hand.cards) do
                if not SMODS.has_any_suit(card) then
                    for suit, count in pairs(suits) do
                        if card:is_suit(suit) and count == 0 then
                            suits[suit] = count + 1
                            break
                        end
                    end
                end
            end
            for _, card in ipairs(G.hand.cards) do
                if SMODS.has_any_suit(card) then
                    for suit, count in pairs(suits) do
                        if card:is_suit(suit) and count == 0 then
                            suits[suit] = count + 1
                            break
                        end
                    end
                end
            end
            local num_suits = 0

            for _, v in pairs(suits) do
                if v > 0 then num_suits = num_suits + 1 end
            end
            if num_suits <= card.ability.extra.suits_allowed then 
                return {
                    xmult = card.ability.extra.x_mult
                }
            end
        end
    end
}