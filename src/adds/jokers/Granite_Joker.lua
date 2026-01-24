SMODS.Joker {
    atlas = "Joker",
    key = "Granite_Joker",
    pos = {
        x = 8,
        y = 4
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = { 
        extra = { 
            mult = 0,
            a_mult = 9
        } 
    },
    pools = {
        Utility = true
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.a_mult,
                card.ability.extra.mult
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.playing_card_added and not context.blueprint then
            local mult_gained = 0
            for _, v in ipairs(context.cards) do
                if SMODS.has_enhancement(v, 'm_stone') then
                    mult_gained = mult_gained + card.ability.extra.a_mult
                end
            end
            if mult_gained > 0 then
                card.ability.extra.mult = card.ability.extra.mult + mult_gained
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
local ref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    local ret = ref(self, center, initial, delay_sprites)

    if self.playing_card and center == G.P_CENTERS['m_stone']and not initial then
        local granite = SMODS.find_card('j_biasedBalance_Granite_Joker')
        for _, v in ipairs(granite) do
            if not v.debuff then
                v.ability.extra.mult = v.ability.extra.mult + v.ability.extra.a_mult
                card_eval_status_text(v, 'extra', nil, nil, nil, {
                    message = localize{type='variable',key='a_mult',vars={v.ability.extra.mult}},
                })
            end
        end
    end

    return ret
end