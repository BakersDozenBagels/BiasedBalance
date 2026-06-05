SMODS.Back {
    key = 'Hibiscus',
    atlas = 'Backs',
    pos = {
        x = 0,
        y = 1
    },
    config = { vouchers = { 'v_biasedBalance_recipe', 'v_biasedBalance_trade_secret' } },
    unlocked = true,
    loc_vars = function(self, info_queue, back)
        return {
            vars = { localize { type = 'name_text', key = self.config.vouchers[1], set = 'Voucher' },
                localize { type = 'name_text', key = self.config.vouchers[2], set = 'Voucher' },
            }
        }
    end,
    apply = function(self)
		G.GAME.modifiers.bbalance_booster_increase1 = 1
        G.GAME.modifiers.bbalance_booster_increase2 = 2
	end,
}
local sc = Card.set_cost_value
function Card:set_cost_value()
	sc(self)

	if self.ability.set == "Booster" and G.GAME.modifiers.bbalance_booster_increase1 then
        if string.match(self.config.center.key, "mega") or string.match(self.config.center.key, "jumbo") then
		    self.cost = math.floor(self.cost + G.GAME.modifiers.bbalance_booster_increase2)
        else
            self.cost = math.floor(self.cost + G.GAME.modifiers.bbalance_booster_increase1)
        end
	end

end