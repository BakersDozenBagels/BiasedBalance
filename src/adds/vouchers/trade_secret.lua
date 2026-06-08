SMODS.Voucher {
    key = 'trade_secret',
    atlas = "Vouchers",
    pos = { x = 1, y = 0 },
    config = { extra = { pack_size = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.pack_size } }
    end,
    requires = { 'v_biasedBalance_recipe' },
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) + 1
                return true
            end
        }))
    end
}

