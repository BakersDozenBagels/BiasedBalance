SMODS.Stake:take_ownership('stake_blue', {
    modifiers = function()
        G.GAME.modifiers.reroll_scale = (G.GAME.modifiers.reroll_scale or 1) + 1
    end,
})
