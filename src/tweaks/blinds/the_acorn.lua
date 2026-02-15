SMODS.Blind {
    key = "acorn",
    atlas = "blinds",
    pos = {
        x = 0,
        y = 11
    },
    discovered = false,
    unlocked = true,
    boss_colour = HEX("fda200"),
    boss = {
		min = 1,
	},
   calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                if #G.jokers.cards > 0 then
                    G.jokers:unhighlight_all()
                    for _, joker in ipairs(G.jokers.cards) do
                        joker:flip()
                    end
                    if #G.jokers.cards > 1 then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.2,
                            func = function()
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.jokers:shuffle('aajk')
                                        play_sound('cardSlide1', 0.85)
                                        return true
                                    end,
                                }))
                                delay(0.15)
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.jokers:shuffle('aajk')
                                        play_sound('cardSlide1', 1.15)
                                        return true
                                    end
                                }))
                                delay(0.15)
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.jokers:shuffle('aajk')
                                        play_sound('cardSlide1', 1)
                                        return true
                                    end
                                }))
                                delay(0.5)
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end
}

SMODS.Blind:take_ownership("final_acorn", { 
    no_collection = true,
	boss = { showdown = false, min = 999 }, })
