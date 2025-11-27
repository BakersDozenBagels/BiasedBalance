SMODS.Joker:take_ownership("hologram", 
{
    config = {extra = 0.175, x_mult = 1},
    loc_vars = function(self, info_queue, card)
        -- Base balatro rounds to 2 decimal places, but that looks stupid.
        return {
            vars = {
                card.ability.extra, card.ability.x_mult, tostring(card.ability.extra), tostring(card.ability.x_mult)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.playing_card_added and not context.blueprint then
            card.ability.x_mult = card.ability.x_mult + #context.cards * card.ability.extra
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { tostring(card.ability.x_mult) } },
            }
        end
        if context.joker_main then
            return {
                Xmult = card.ability.x_mult
            }
        end
    end,
})