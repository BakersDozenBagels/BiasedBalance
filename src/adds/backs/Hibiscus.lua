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
    calculate = function(self, card, context) 
    
    end
}