SMODS.Joker {
    atlas = "Joker",
    key = "Shy_Joker",
    pos = {
        x = 5,
        y = 2
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 12 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.press_play and not context.blueprint then
            G.E_MANAGER:add_event(Event({ trigger = "after", delay = 0.5, func = function()
				local any_selected = nil
				for i = 1, #G.hand.cards do
					local selected_card = G.hand.cards[i]
					if selected_card:is_face() then 
						G.hand.highlighted[#G.hand.highlighted+1] = selected_card
            			selected_card:highlight(true)
						any_selected = true
						play_sound('card1', 1)
					end
				end
				if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
			return true end })) 
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

