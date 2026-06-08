SMODS.Voucher:take_ownership('reroll_surplus', {
    loc_vars = function(self, info_queue, card)
        local vars = { vars = { card.ability.extra } }
        if G.GAME.stake >= 5 then
            vars.key = 'v_reroll_surplus_blue'
            end
        return vars
    end,
    set_ability = function(self, card, initial, delay_sprites)
	    if G.GAME.stake >= 5 then
		    card.ability.extra = card.ability.extra - 1
            
		end
	end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - card.ability.extra
                G.GAME.current_round.reroll_cost = math.max(0,
                    G.GAME.current_round.reroll_cost - card.ability.extra)
                    
                if G.GAME.stake >= 5 then
                    G.GAME.modifiers.reroll_scale = (G.GAME.modifiers.reroll_scale or 1) - card.ability.extra
                end
                return true
            end
        }))
    end
})