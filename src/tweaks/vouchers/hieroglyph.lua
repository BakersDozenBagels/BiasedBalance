SMODS.Voucher:take_ownership('hieroglyph', {
    config = { extra = { deduction = 1 } },
    loc_vars = function(self, info_queue, card)
        return { key = G.GAME.Biased_Balance.pink_stake_active and 'v_hieroglyph_pink' or 'v_hieroglyph', vars = { card.ability.extra.deduction } }
    end,
    cost = 10,
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(-card.ability.extra.deduction)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.deduction

        if G.GAME.Biased_Balance.pink_stake_active then
            -- Apply discard change
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.deduction
            ease_discard(-card.ability.extra.deduction)
        else 
            -- Apply hand change
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.deduction
            ease_hands_played(-card.ability.extra.deduction)
        end
    end,
})
local sc = Card.set_cost_value
function Card:set_cost_value()
	sc(self)

	if self.config.center.key == "v_hieroglyph" and G.GAME.Biased_Balance.pink_stake_active then
		self.cost = math.floor(self.cost + 5)
	end

end