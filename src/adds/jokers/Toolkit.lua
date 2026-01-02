SMODS.Joker {
    atlas = "Joker",
    key = "Toolkit",
    pos = {
        x = 4,
        y = 2
    },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
            G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            SMODS.calculate_effect({ message = localize('k_biasedBalance_utility'), colour = G.C.FILTER },
                        context.blueprint_card or card)
                            SMODS.add_card {
                                set = 'Utility',
                                key_append = 'Toolkit',
                                edition = poll_edition('utilitytoolkit', nil, true, true, { 'e_polychrome', 'e_holo', 'e_foil' })
                            }
                            return true
                        end
                    }))
            card:start_dissolve()
        end
    end
}