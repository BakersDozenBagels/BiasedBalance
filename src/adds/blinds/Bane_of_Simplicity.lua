SMODS.Blind {
    key = "final_bane",
    dollars = 8,
    mult = 2,
    pos = { x = 0, y = 3 },
    odds = 4,
    atlas = "blinds",
    boss = { showdown = true },
    loc_vars = function(self)
        
    end,
    boss_colour = HEX("4f6367"),
    calculate = function(self, blind, context)
        if not blind.disabled and context.final_scoring_step then
            local subtract = 225
            print(hand_chips)
            print(subtract)
            if hand_chips - subtract <= 5 then
                subtract = hand_chips - 5
            end
            return {chip_mod = -1 * subtract}
        end
    end
}
