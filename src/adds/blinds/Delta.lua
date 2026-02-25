SMODS.Blind {
    key = "Delta",
    atlas = "blinds",
    pos = {
        x = 0,
        y = 7
    },
    boss = {
		min = 6,
	},
    boss_colour = HEX("4da28e"),
    
}

local scie = SMODS.calculate_individual_effect
		function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
			local ret = scie(effect, scored_card, key, amount, from_edition)
			if
				(
					key == "x_mult"
					or key == "xmult"
					or key == "Xmult"
					or key == "x_mult_mod"
					or key == "xmult_mod"
					or key == "Xmult_mod"
				)
				and amount ~= 1
				and mult
			then
                if not G.GAME.blind.disabled and G.GAME.blind.name == 'bl_biasedBalance_Delta' then
                    local final_chips = (G.GAME.blind.chips / 100) * (130)
                    local chip_mod -- iterate over ~120 ticks
                    chip_mod = math.ceil((final_chips - G.GAME.blind.chips) / 120)
                    local step = 0
                    G.E_MANAGER:add_event( Event ({
                        trigger = 'after', 
                        blocking = true, 
                        func = function()
                        G.GAME.blind.chips = G.GAME.blind.chips + G.SETTINGS.GAMESPEED * chip_mod
                        if G.GAME.blind.chips < final_chips then
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                            if step % 5 == 0 then
                                play_sound('chips1', 0.8 + (step * 0.005))
                            end
                            step = step + 1
                        else
                            G.GAME.blind.chips = final_chips
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                            G.GAME.blind:wiggle()
                            return true
                        end
                    end}))
                end
			end
			return ret
		end