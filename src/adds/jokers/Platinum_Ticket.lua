SMODS.Joker {
    atlas = "Joker",
    key = "Platinum_Ticket",
    pos = {
        x = 11,
        y = 5
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            xmult = 1.0,
            xmult_mod = 0.2,
            money = 1
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.xmult_mod,
                card.ability.extra.xmult + redeemed_voucher_count() * card.ability.extra.xmult_mod,
                card.ability.extra.money,
                redeemed_voucher_count() * card.ability.extra.money
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.buying_card and context.card.ability.set == "Voucher" then
            G.E_MANAGER:add_event(Event({
                func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult + redeemed_voucher_count()* card.ability.extra.xmult_mod}}}); return true
                end}))
            return
        end
        if context.joker_main then
            local mult = redeemed_voucher_count() * card.ability.extra.xmult_mod
            if mult > 0 then
                return {
                    xmult = card.ability.extra.xmult + mult,
                }
            end
        end
    end,

    calc_dollar_bonus = function(self, card)
        local voucher_count = redeemed_voucher_count()
        if voucher_count > 0 then
            return card.ability.extra.money * voucher_count
        end
    end
}