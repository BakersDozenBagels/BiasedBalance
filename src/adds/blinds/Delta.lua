SMODS.Blind {
    key = "Delta",
    atlas = "blinds",
    pos = {
        x = 0,
        y = 6
    },
    boss = {
		min = 6,
	},
    boss_colour = HEX("7db450"),
    
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
                print("xmult thingy triggered")
                if not G.GAME.blind.disabled and G.GAME.blind.name == 'bl_biasedBalance_Delta' then
                    print("inside count")
                    local final_chips = (G.GAME.blind.chips / 100) * (130)
                    local chip_mod -- iterate over ~120 ticks
                    chip_mod = math.ceil((final_chips - G.GAME.blind.chips) / 120)
                    local step = 0
                    G.E_MANAGER:add_event( Event ({
                        trigger = 'after', 
                        blocking = true, 
                        func = function()
                            print("inside event")
                        G.GAME.blind.chips = G.GAME.blind.chips + G.SETTINGS.GAMESPEED * chip_mod
                        if G.GAME.blind.chips < final_chips then
                            print("inside chips < final chips")
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                            if step % 5 == 0 then
                                play_sound('chips1', 0.8 + (step * 0.005))
                            end
                            step = step + 1
                        else
                            print("inside chips else")
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
--[[
if context.post_trigger and context.other_ret and context.other_card then
            if context.other_ret.jokers and not context.other_card.ability.gored6 then
                if context.other_ret.jokers.x_chips or context.other_ret.jokers.e_chips or context.other_ret.jokers.ee_chips or context.other_ret.jokers.eee_chips or context.other_ret.jokers.hyper_chips then
                    if context.cardarea == G.jokers then
                        card.ability.extra.xchips_triggered = true
                        context.other_card.ability.gored6 = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.jokers:remove_card(context.other_card)
                                context.other_card:gore6_break()
                                
                                card:juice_up(2, 0.5)
                                return true
                            end,
                        }))
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize('k_unik_xchips_not_vanilla' .. math.random(1,4)),
                            colour = G.C.RED,
                            card=card,
                        })
                    else
                        context.other_card.ability.fuck_xchips = true
                    end
                end
            end
            
        end
        
        
        calculate = function(self, blind, context)
            if not blind.disabled then
                if context.post_trigger and context.other_ret and context.other_card then
                    if context.other_ret.jokers and context.other_ret.jokers.x_mult then
                        G.GAME.blind.chips = G.GAME.blind.chips + G.GAME.blind.chips * 0.3
                        blind.triggered = true
                        delay(0.7)
                        G.E_MANAGER:add_event(Event({
                            trigger = 'immediate',
                            func = (function()
                                SMODS.juice_up_blind()
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.06 * G.SETTINGS.GAMESPEED,
                                    blockable = false,
                                    blocking = false,
                                    func = function()
                                        play_sound('tarot2', 0.76, 0.4); return true
                                    end
                                }))
                                play_sound('tarot2', 1, 0.4)
                                return true
                            end)
                        }))
                        delay(0.4)
                end
            end
        end
    end]]