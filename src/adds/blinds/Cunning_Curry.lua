SMODS.Blind {
    key = "final_curry",
    dollars = 8,
    mult = 2,
    pos = { x = 0, y = 1 },
    odds = 4,
    atlas = "blinds",
    boss = { showdown = true },
    loc_vars = function(self)
        local numerator, denominator = SMODS.get_probability_vars(self, 1, 4, 'curry')
        return { vars = { numerator, denominator } }
    end,
    collection_loc_vars = function(self)
        return { vars = { '1' } }
    end,
    boss_colour = HEX("d75c00"),
    set_blind = function(self)
        for k, v in pairs(G.playing_cards) do
            if SMODS.pseudorandom_probability(self, pseudoseed('curry'), 1, 4, 'curry') then
                SMODS.debuff_card(v, true, 'curry')
            end
        end
    end,
    disable = function(self)
        for k, v in pairs(G.playing_cards) do
        SMODS.debuff_card(v, false, 'curry')
        end
    end,

    defeat = function(self)
        for k, v in pairs(G.playing_cards) do
        SMODS.debuff_card(v, false, 'curry')
        end
    end
}
