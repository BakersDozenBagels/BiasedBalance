SMODS.Joker {
    atlas = "Joker",
    key = "WhiteHole",
    pos = {
        x = 10,
        y = 2
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    config = { extra = { rounds = 0, rounds_needed = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rounds_needed, card.ability.extra.rounds } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds == card.ability.extra.rounds_needed then
                juice_card_until(card, function(x) return not x.REMOVED end, true)
            end
            return {
                message = (card.ability.extra.rounds < card.ability.extra.rounds_needed) and
                    (card.ability.extra.rounds .. '/' .. card.ability.extra.rounds_needed) or localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
        if context.selling_self and card.ability.extra.rounds >= card.ability.extra.rounds_needed and not context.blueprint then
            update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
				{ handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
			)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					play_sound("tarot1")
					card:juice_up(0.8, 0.5)
					G.TAROT_INTERRUPT_PULSE = true
					return true
				end,
			}))
			update_hand_text({ delay = 0 }, { mult = "+", StatusText = true })
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.9,
				func = function()
					play_sound("tarot1")
					card:juice_up(0.8, 0.5)
					return true
				end,
			}))
			update_hand_text({ delay = 0 }, { chips = "+", StatusText = true })
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.9,
				func = function()
					play_sound("tarot1")
					card:juice_up(0.8, 0.5)
					G.TAROT_INTERRUPT_PULSE = nil
					return true
				end,
			}))
			update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+1" })
			delay(1.3)
			for k, v in pairs(G.GAME.hands) do
				level_up_hand(card, k, true)
			end
			update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
				{ mult = 0, chips = 0, handname = "", level = "" }
			)
        end
    end,
    load = function(self, card, card_table, other_card)
        if card_table.ability.extra.rounds >= card_table.ability.extra.rounds_needed then
            juice_card_until(card, function(x) return not x.REMOVED end, true)
        end
    end
}