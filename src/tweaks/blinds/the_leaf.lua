SMODS.Blind {
    key = "leaf",
    atlas = "blinds",
    pos = {
        x = 0,
        y = 0
    },
    discovered = false,
    unlocked = true,
    boss_colour = HEX("56a786"),
    boss = {
		min = 4,
	},
   calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers then
                return {
                    debuff = true
                }
            end
            if context.selling_card and context.card.ability.set == 'Joker' then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        blind:disable()
                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Blind:take_ownership("final_leaf", { 
    no_collection = true,
	boss = { showdown = false, min = 999 }, })
