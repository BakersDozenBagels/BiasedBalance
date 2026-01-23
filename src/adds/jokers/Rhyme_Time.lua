SMODS.Joker {
    atlas = "Joker",
    key = "Rhyme_Time",
    pos = {
        x = 4,
        y = 5
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            xmult = 2.5,
            required_count = 2
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.xmult,
                card.ability.extra.required_count
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local cards = {
                ['Evens'] = {},
                ['Odds'] = {},
            }
            local seen = {} 
            for i, v in ipairs(context.scoring_hand) do
                local id = v:get_id()

                local is_even = id <= 10 and id >= 0 and id % 2 == 0
                local is_odd  = (id <= 10 and id >= 0 and id % 2 == 1) or id == 14

                if not seen[id] then
                    if is_even then
                        table.insert(cards['Evens'], v)
                        seen[id] = true
                    elseif is_odd then
                        table.insert(cards['Odds'], v)
                        seen[id] = true
                    end
                end
            end
            if #cards['Evens'] >= card.ability.extra.required_count or #cards['Odds'] >= card.ability.extra.required_count then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}