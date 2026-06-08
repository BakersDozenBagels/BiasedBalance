SMODS.Back:take_ownership("green", {})

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