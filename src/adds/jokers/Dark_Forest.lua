SMODS.Joker {
    atlas = "Joker",
    key = "Dark_Forest",
    pos = {
        x = 0,
        y = 4
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            xmult_base = 3,
            xmult_gain = .07,
            xmult = 3
        } 
    },
    loc_vars = function(self, info_queue, card)
        card.ability.extra.xmult = card.ability.extra.xmult_base
        if G.playing_cards then
            for _, c in ipairs(G.playing_cards) do
                if c:is_suit("Diamonds") and not SMODS.has_any_suit(card) then
                    card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_gain
                elseif c:is_suit("Hearts") and not SMODS.has_any_suit(card) then
                    card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_gain
                end
            end
        end
        return { 
            vars = { 
                card.ability.extra.xmult_gain,
                math.max(1, card.ability.extra.xmult)
            } 
    }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.xmult = card.ability.extra.xmult_base
            for _, c in ipairs(G.playing_cards or {}) do
                if c:is_suit("Diamonds") and not SMODS.has_any_suit(card) then
                    card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_gain
                elseif c:is_suit("Hearts") and not SMODS.has_any_suit(card) then
                    card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_gain
                end
            end
            return {
                xmult = math.max(1, card.ability.extra.xmult)
            }
        end
    end
}