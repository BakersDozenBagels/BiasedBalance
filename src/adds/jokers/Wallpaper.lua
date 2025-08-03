SMODS.Joker {
    atlas = "Joker",
    key = "WallPaper",
    pos = {
        x = 0,
        y = 4
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            x_mult = 2 
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.x_mult
        } 
    }
    end,
    calculate = function(self, card, context)
        local suit_checker = nil
        if context.before then 
            local suit_count = 0
            for i, v in ipairs(context.scoring_hand) do
                if v:is_suit("Hearts") then
                    suit_count = suit_count + 1
                elseif v:is_suit("Diamonds") then
                     suit_count = suit_count + 1
                elseif v:is_suit("Spades") then
                    suit_count = suit_count + 1
                elseif v:is_suit("Clubs") then
                    suit_count = suit_count + 1
                end
            end
            if suit_count <= 2 then 
                suit_checker = true
            end
        end
        if context.joker_main then
            if suit_checker then
                return {
                    xmult = card.ability.extra.x_mult
                }
            end
        end
    end
}