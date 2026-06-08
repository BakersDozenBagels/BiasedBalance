SMODS.Blind {
    key = "final_garden",
    dollars = 8,
    mult = 2,
    pos = { x = 0, y = 2 },
    odds = 4,
    atlas = "blinds",
    boss = { showdown = true },
    loc_vars = function(self)
        return { vars = { localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands') } }
    end,
    collection_loc_vars = function(self)
        return { vars = { localize('ph_most_played') } }
    end,
    boss_colour = HEX("6b5a00"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand then
                blind.triggered = false
                if context.scoring_name == G.GAME.current_round.most_played_poker_hand then
                    blind.triggered = true
                    return {
                        debuff = true
                    }
                end
            end
        end
    end
}
