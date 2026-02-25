SMODS.Blind {
    key = "Gamma",
    atlas = "blinds",
    pos = {
        x = 0,
        y = 6
    },
    boss = {
		min = 4,
	},
    boss_colour = HEX("7db450"),
    
}
local eval_ret = eval_card
function eval_card(card, context)
    local ret = eval_ret(card, context)
    if (not G.GAME.blind.disabled and G.GAME.blind.name == 'bl_biasedBalance_Gamma') then
        ret.edition = nil
        ret.enhancement = nil
        ret.seals = nil
    end
    return ret
end