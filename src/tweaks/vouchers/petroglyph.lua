SMODS.Voucher:take_ownership('petroglyph', {
    config = { extra = { deduction = 1 } },
    loc_vars = function(self, info_queue, card)
        return { key = G.GAME.Biased_Balance.pink_stake_active and 'v_petroglyph_pink' or 'v_petroglyph', vars = { card.ability.extra.deduction } }
    end,
    cost = 10,
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(-card.ability.extra.deduction)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.deduction

        if G.GAME.Biased_Balance.pink_stake_active then
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { mult = '-', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { chips = '-', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '-1' })
        delay(1.3)
        local hands = {}
        for _, hand in ipairs(G.handlist) do
            if G.GAME.hands[hand].level > 1 then
                table.insert(hands, hand)
            end
        end
        SMODS.upgrade_poker_hands({ instant = true, level_up = -1, hands = hands })

        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })
        else 
            -- Apply discard change
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.deduction
            ease_discard(-card.ability.extra.deduction)
        end
    end,
})
local sc = Card.set_cost_value
function Card:set_cost_value()
	sc(self)

	if self.config.center.key == "v_petroglyph" and G.GAME.Biased_Balance.pink_stake_active then
		self.cost = math.floor(self.cost + 5)
	end

end