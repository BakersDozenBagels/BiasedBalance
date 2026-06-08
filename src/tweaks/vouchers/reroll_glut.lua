SMODS.Voucher:take_ownership('reroll_glut', {
    set_ability = function(self, card, initial, delay_sprites)
	    if G.GAME.stake >= 5 then
		    card.ability.extra = card.ability.extra + 1
		end
	end,
})