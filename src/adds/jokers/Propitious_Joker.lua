SMODS.Joker {
    atlas = "Joker",
    key = "Propitious_Joker",
    pos = {
        x = 6,
        y = 7
    },
    rarity = 3,
    cost = 7,
    pools = { Utility = true},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local sevens = 0
            local luckysevens = 0
            local converted = 0
            -- check if lucky 7 was scored
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:get_id() == 7 and SMODS.has_enhancement(scored_card, 'm_lucky') then
                    luckysevens = luckysevens + 1
                end
            end
            for _, scored_card in ipairs(context.scoring_hand) do
                -- find all unenhanced 7s and convert to lucky
                if scored_card:get_id() == 7 then
                    sevens = sevens + 1
                    scored_card:set_ability('m_lucky', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if luckysevens > 0 then
                -- convert random scoring card to lucky, prioritizing unenhanced cards
                local candidates = {}
                for _, scored_card in ipairs(context.scoring_hand) do
                    if scored_card.config.center == G.P_CENTERS.c_base and scored_card:get_id() ~= 7 then
                        candidates[#candidates + 1] = scored_card
                    end
                end
                -- if not enough unenhanced cards, include enhanced ones
                if #candidates < luckysevens then
                    for _, scored_card in ipairs(context.scoring_hand) do
                        if scored_card:get_id() ~= 7 then
                            candidates[#candidates + 1] = scored_card
                        end
                    end
                end
                -- convert as many as possible
                for i = 1, luckysevens do
                    local index = math.random(1, #candidates)
                    local to_convert = candidates[index]
                    to_convert:set_ability('m_lucky', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            to_convert:juice_up()
                            return true
                        end
                    }))
                    converted = converted + 1
                    table.remove(candidates, index)
                end
            end
            if sevens > 0 or converted > 0 then
                return {
                    message = localize('k_biasedBalance_lucky'),
                    colour = G.C.MONEY
                }
            end
        end
    end,
}