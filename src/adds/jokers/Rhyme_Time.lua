SMODS.Joker {
    atlas = "Joker",
    key = "Rhyme_Time",
    pos = {
        x = 4,
        y = 5
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            mult = 0,
            a_mult = 10,
            required_count = 3,
            active = true
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult,
                card.ability.extra.required_count,
                card.ability.extra.a_mult
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local cards = {
                ['Evens'] = {},
                ['Odds'] = {},
            }
            local seen = {} 
            for i, v in ipairs(context.scoring_hand) do
                local id = v:get_id()

                local is_even = id <= 10 and id >= 0 and id % 2 == 0
                local is_odd  = (id <= 10 and id >= 0 and id % 2 == 1) or id == 14

                --if not seen[id] then
                    if is_even then
                        table.insert(cards['Evens'], v)
                        seen[id] = true
                    elseif is_odd then
                        table.insert(cards['Odds'], v)
                        seen[id] = true
                    end
                --end
            end
            if #cards['Evens'] >= card.ability.extra.required_count or #cards['Odds'] >= card.ability.extra.required_count then
                --card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_mult
                --return {
                --    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.a_mult } }
                --}
                card.ability.extra.active = true
            end
        end
        if context.joker_main and card.ability.extra.active then
            return {
                mult = card.ability.extra.a_mult
            }
        end
        if context.after then
            card.ability.extra.active = false
        end
    end
}