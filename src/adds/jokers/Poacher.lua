SMODS.Joker {
    atlas = "Joker",
    key = "Poacher",
    pos = {
        x = 6,
        y = 3
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {odds = 7} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local faces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card.config.center.key == 'c_base' and pseudorandom ('j_biasedBalance_Poacher') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    faces = faces + 1
                    scored_card:set_ability('m_wild', nil, true)
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
                    message = localize('k_biasedBalance_pow'),
                }
            end
        end
    end
}