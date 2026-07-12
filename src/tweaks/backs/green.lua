SMODS.Back:take_ownership("green", {
    config = { fake_extra_hand_bonus = 2, fake_extra_discard_bonus = 1, },
    loc_vars = function(self, info_queue, back)
        local vars = { self.config.fake_extra_hand_bonus, self.config.fake_extra_discard_bonus } 
        if G.GAME.Biased_Balance.pink_stake_active then
            vars = { self.config.fake_extra_hand_bonus + 1, self.config.fake_extra_discard_bonus } 
        end
        return { key = G.GAME.Biased_Balance.pink_stake_active and 'b_green_pink' or 'b_green', vars = vars }
    end,
    
    apply = function(self, back)
        
        if G.GAME.Biased_Balance.pink_stake_active then
            G.GAME.modifiers.money_per_hand = self.config.fake_extra_hand_bonus + 1
            G.GAME.modifiers.money_per_discard = self.config.fake_extra_discard_bonus
            G.GAME.modifiers.no_interest = true
        else 
            G.GAME.modifiers.money_per_hand = self.config.fake_extra_hand_bonus
            G.GAME.modifiers.money_per_discard = self.config.fake_extra_discard_bonus
            G.GAME.modifiers.no_interest = true
        end
    end,
})

SMODS.Voucher:take_ownership('seed_money', {
    in_pool = function(self, args)
    if G.GAME and G.GAME.selected_back.effect.center.key == "b_green" then
        return false
    else
        return true
    end
  end,
})

SMODS.Voucher:take_ownership('money_tree', {
    in_pool = function(self, args)
    if G.GAME and G.GAME.selected_back.effect.center.key == "b_green" then
        return false
    else
        return true
    end
  end,
})