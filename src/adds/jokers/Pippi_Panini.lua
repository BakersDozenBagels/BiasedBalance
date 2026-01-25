SMODS.Joker {
    atlas = "Joker",
    key = "Pippi_Panini",
    pos = {
        x = 9,
        y = 7
    },
    rarity = 4,
    cost = 20,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local faces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card.config.center ~= G.P_CENTERS.c_base then
                    faces = faces + 1
                    if not scored_card.seal then
                        scored_card:set_seal(
								SMODS.poll_seal({ guaranteed = true, type_key = "pippi" })
							)
                    end
                    if not scored_card.edition then
                        scored_card:set_edition(
								poll_edition('panini', nil, true, true,
                { 'e_polychrome', 'e_holo', 'e_foil', 'e_negative' })
							)
                    end
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if faces > 0 then
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MONEY
                }
            end
        end
    end,
}