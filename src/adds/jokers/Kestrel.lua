SMODS.Joker {
    atlas = "Joker",
    key = "Kestrel",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            mult = 0,
            mult_gain = 3
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult_gain,
                card.ability.extra.mult
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
             for _, c in ipairs(G.playing_cards or {}) do
                if SMODS.get_enhancements(c, false) then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                end
            end
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}