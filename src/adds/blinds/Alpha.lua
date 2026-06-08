SMODS.Blind {
    key = "Alpha",
    dollars = 5,
    mult = 2,
    atlas = "blinds",
    pos = {
        x = 0,
        y = 4
    },
    boss = { min = 3 },
    loc_vars = function(self)
        return { vars = { G.GAME.Biased_Balance.most_common_rank, G.GAME.Biased_Balance.second_most_common_rank } }
    end,
    collection_loc_vars = function(self)
        return { vars = { '(Most common rank)', ('(2nd most common rank)') } }
    end,
    boss_colour = HEX("1e6fb7"),
    set_blind = function(self)
        for k, v in pairs(G.playing_cards) do
            if G.GAME.Biased_Balance.most_common_ranks_at_ante and (v.base.value == G.GAME.Biased_Balance.most_common_rank or 
            v.base.value == G.GAME.Biased_Balance.second_most_common_rank) then
                SMODS.debuff_card(v, true, 'sapphire')
            end
        end
    end,
    disable = function(self)
        for k, v in pairs(G.playing_cards) do
            SMODS.debuff_card(v, false, 'sapphire')
        end
    end,

    defeat = function(self)
        for k, v in pairs(G.playing_cards) do
            SMODS.debuff_card(v, false, 'sapphire')
        end
    end
}
