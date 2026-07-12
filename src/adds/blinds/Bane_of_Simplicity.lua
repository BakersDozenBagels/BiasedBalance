SMODS.Blind {
    key = "final_bane",
    dollars = 8,
    mult = 2,
    pos = { x = 0, y = 3 },
    odds = 4,
    atlas = "blinds",
    boss = { showdown = true },
    loc_vars = function(self)
        return { vars = { 30 + 25 * (G.GAME.round_resets.ante or 0) } }
    end,
    collection_loc_vars = function(self)
        return { vars = { "(30 + (25 * Ante))" } }
    end,
    boss_colour = HEX("4f6367"),
    calculate = function(self, blind, context)
        if not blind.disabled and context.final_scoring_step then
            local subtract = 30 + 25 * (G.GAME.round_resets.ante or 0)
            print(hand_chips)
            print(subtract)
            if hand_chips - subtract <= 5 then
                subtract = hand_chips - 5
            end
            return {chip_mod = -1 * subtract}
        end
    end
}
