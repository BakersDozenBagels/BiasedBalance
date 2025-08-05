SMODS.Blind {
    key = "Omega",
    atlas = "blinds",
    pos = {
        x = 0,
        y = 0
    },
    discovered = false,
    unlocked = true,
    order = 1,
    boss_colour = HEX("883a3b"),
    boss = {
		min = 5,
	},
    calculate = function(self, card, context)
        if context.final_scoring_step then
            local ante = G.GAME.ante or 5
            local x_value = 0

            if ante == 5 then x_value = 110
            elseif ante == 6 then x_value = 125
            elseif ante == 7 then x_value = 140
            elseif ante == 8 then x_value = 155
            else x_value = 155 end
            
           return hand_chips - math.max(-x_value, 5), mult
        end
    end
}