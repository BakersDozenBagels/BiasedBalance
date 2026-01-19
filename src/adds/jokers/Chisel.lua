SMODS.Joker {
    atlas = "Joker",
    key = "Chisel",
    pos = {
        x = 7,
        y = 4
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            found_stone = false
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 

        } 
    }
    end,
    calculate = function(self, card, context)
        if context.cardarea == "unscored" and context.main_eval and G.GAME.current_round.hands_played == 0 and not card.ability.extra.found_stone then
            local unscored_cards = {}
			for index = 1, #context.full_hand do
				if not SMODS.in_scoring(context.full_hand[index], context.scoring_hand) then
					if context.full_hand[index].ability and not context.full_hand[index].ability.buf_argument then
						unscored_cards[#unscored_cards+1] = context.full_hand[index]
					end
				end
			end
            if #unscored_cards ~= 0 then
                card.ability.extra.found_stone = true
				local stoned_card = pseudorandom_element(unscored_cards)
                G.E_MANAGER:add_event(Event({
                        func = function()
				            stoned_card:set_ability('m_stone')
                            stoned_card:juice_up()
                            return true
                        end
                    }))
                return {
                message = localize('k_biasedBalance_stone'),
                colour = G.C.SECONDARY_SET.Enhanced
            }
            end
        end
        if context.end_of_round then
            card.ability.extra.found_stone = false
        end
    end
}