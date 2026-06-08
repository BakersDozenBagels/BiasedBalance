SMODS.Joker {
    key = "Eclectic_Joker",
    atlas = "Joker",
    pos = {
        x = 8,
        y = 1
    },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = {
        extra = {
            a_mult = 3,
            sub_mult = 1,
            mult = 0,
            first_hand = nil,
            second_hand = nil
        }
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.a_mult,
                card.ability.extra.sub_mult,
                card.ability.extra.mult
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.before then
        local is_new_hand =
            not context.blueprint
            and context.scoring_name ~= card.ability.extra.first_hand
            and context.scoring_name ~= card.ability.extra.second_hand

        if is_new_hand then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_mult
        else
            card.ability.extra.mult = math.max(0, card.ability.extra.mult - card.ability.extra.sub_mult)
        end

        if card.ability.extra.first_hand == nil then
            card.ability.extra.first_hand = context.scoring_name
        elseif card.ability.extra.second_hand == nil then
            card.ability.extra.second_hand = context.scoring_name
        else
            card.ability.extra.first_hand = card.ability.extra.second_hand
            card.ability.extra.second_hand = context.scoring_name
        end

        return {
            message = 
            is_new_hand
            and ("+" .. card.ability.extra.a_mult)
            or  ("-" .. card.ability.extra.sub_mult),
            colour = is_new_hand and G.C.FILTER or G.C.RED
            }
        end


        if context.joker_main then
        return {
            mult = card.ability.extra.mult
        }
        end
    end
}