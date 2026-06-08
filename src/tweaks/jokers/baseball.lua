SMODS.Joker:take_ownership("baseball", { 
    config = { extra = { xmult = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker:is_rarity("Uncommon") then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
 })