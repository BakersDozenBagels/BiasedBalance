SMODS.Joker {
    atlas = "Joker",
    key = "Strength_In_Numbers",
    pos = {
        x = 12,
        y = 5
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            mult = 2
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.other_card:is_face() then
            local dupecheck = 0
            for _, v in pairs(G.playing_cards) do
                if context.other_card:get_id() == v:get_id() then
                    dupecheck = dupecheck + 1
                end
            end
            if dupecheck > 4 then
                dupecheck = dupecheck - 4
                return {
                    mult = card.ability.extra.mult * dupecheck
                }
            end
        end
    end
}