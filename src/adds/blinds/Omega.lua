SMODS.Blind {
    key = "Omega",
    atlas = "blinds",
    pos = {
        x = 0,
        y = 10
    },
    loc_vars = function(self)
        local ante = G.GAME.round_resets.ante or 5
        local x_value = 0

        if ante <= 5 then x_value = 110
        elseif ante <= 6 then x_value = 125
        elseif ante <= 7 then x_value = 140
        elseif ante == 8 then x_value = 155
        else x_value = 155 end
        return { vars = { x_value } }
    end,
    collection_loc_vars = function(self)
        local ante = G.GAME.round_resets.ante or 5
        local x_value = 0

        if ante <= 5 then x_value = 110
        elseif ante <= 6 then x_value = 125
        elseif ante <= 7 then x_value = 140
        elseif ante == 8 then x_value = 155
        else x_value = 155 end
        return { vars = { x_value } }
    end,
    boss_colour = HEX("e23539"),
    boss = {
		min = 5,
	},
    calculate = function(self, card, context)
        if context.final_scoring_step then
            local ante = G.GAME.round_resets.ante or 5
            local x_value = 0

            if ante <= 5 then x_value = 110
            elseif ante <= 6 then x_value = 125
            elseif ante <= 7 then x_value = 140
            elseif ante <= 8 then x_value = 155
            else x_value = 155 end

            if hand_chips - x_value <= 5 then
                x_value = hand_chips - 5
            end
            
           return {chip_mod = -1 * x_value}
        end
    end
}