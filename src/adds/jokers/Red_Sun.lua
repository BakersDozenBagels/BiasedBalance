SMODS.Joker {
    atlas = "Joker",
    key = "RedSun",
    pos = {
        x = 8,
        y = 2
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = 2.5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local h, d, w = 0, 0, 0
            for k, v in pairs(context.scoring_hand) do
                if SMODS.has_any_suit(v) or (v:is_suit("Diamonds") and v:is_suit("Hearts")) then
                    w = w + 1
                elseif v:is_suit("Diamonds") then
                    d = 1
                elseif v:is_suit("Hearts") then
                    h = 1
                elseif not SMODS.has_no_suit(v) then
                    return
                end
            end
            if h + d + w >= 2 then
                return {
                    x_mult = card.ability.extra
                }
            end
        end
    end
}