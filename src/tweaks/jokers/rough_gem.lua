SMODS.Joker:take_ownership("rough_gem", {
    config = { extra = { odds = 2, dollars = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") then
            local amount = (pseudorandom(pseudoseed('rough_gem')) < G.GAME.probabilities.normal / card.ability.extra.odds)
                and card.ability.extra.dollars or 0
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + amount
            if not Talisman or not Talisman.config_file.disable_anims then
                G.E_MANAGER:add_event(Event {
                    func = function()
                        G.GAME.dollar_buffer = 0; return true
                    end
                })
            else
                G.GAME.dollar_buffer = 0
            end
            if amount == 0 then return {} end
            return {
                dollars = amount
            }
        end
    end
})