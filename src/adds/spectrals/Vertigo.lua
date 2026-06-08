SMODS.Consumable {
    key = 'Vertigo',
    set = 'Spectral',
    atlas = 'Spectrals',
    pos = {
        x = 1,
        y = 2
    },
    config = { extra = { seal = 'biasedBalance_Teal' }, max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] =
			{ set = "Other", key = "biasedbalance_teal_seal"}
        return { vars = { card.ability.max_highlighted, colours = {HEX('79bbc3') } } }
    end,
    cost = 4,
	use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
}