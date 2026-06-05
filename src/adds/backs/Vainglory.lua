SMODS.Back {
    key = 'Vainglory',
    atlas = 'Backs',
    pos = {
        x = 2,
        y = 1
    },
    config = { current_price = 0 },
    loc_vars = function(self, info_queue, back)
        return { vars = {  } }
    end,
    calculate = function(self, card, context) 
        if context.end_of_round then
            G.GAME.current_round.voucher = SMODS.get_next_vouchers()
        end
        if context.buying_card and context.card.ability.set == "Voucher" then
            G.GAME.modifiers.bbalance_voucher_increase = (G.GAME.modifiers.bbalance_voucher_increase or 0) + 5
            G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
        end
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
            G.GAME.modifiers.bbalance_voucher_increase = 0
        end
    end
}
local sc = Card.set_cost_value
function Card:set_cost_value()
	sc(self)

	if self.ability.set == "Voucher" and G.GAME.modifiers.bbalance_voucher_increase then
		self.cost = math.floor(self.cost + G.GAME.modifiers.bbalance_voucher_increase)
	end

end