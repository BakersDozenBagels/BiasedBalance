SMODS.Joker {
    atlas = "Joker",
    key = "Kestrel",
    pos = {
        x = 4,
        y = 1
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
        local driver_tally = 0
        for _, playing_card in pairs(G.playing_cards or {}) do
            if next(SMODS.get_enhancements(playing_card)) then driver_tally = driver_tally + 1 end
        end
        return { 
            vars = { 
                card.ability.extra.mult_gain,
                card.ability.extra.mult_gain * driver_tally
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
             for _, c in ipairs(G.playing_cards or {}) do
                if next(SMODS.get_enhancements(c)) then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                end
            end
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}