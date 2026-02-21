SMODS.Blind {
    key = "Beta",
    dollars = 5,
    mult = 2,
    atlas = "blinds",
    pos = {
        x = 0,
        y = 5
    },
    boss = { min = 1 },
    boss_colour = HEX("83d1db"),
    calculate = function(self, blind, context)
        if context.before and not G.GAME.blind.disabled then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            for i = 1, #G.hand.cards do
                if not G.hand.cards[i].debuffed then
                    G.E_MANAGER:add_event(Event({func = function() SMODS.debuff_card(G.hand.cards[i], true, 'diamond') G.hand.cards[i]:juice_up(); return true end })) 
                end
            end
            return true end })) 
        end
    end,
    disable = function(self)
        for k, v in pairs(G.playing_cards) do
            SMODS.debuff_card(v, false, 'diamond')
        end
    end,

    defeat = function(self)
        for k, v in pairs(G.playing_cards) do
            SMODS.debuff_card(v, false, 'diamond')
        end
    end
}
