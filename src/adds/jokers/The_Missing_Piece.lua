SMODS.Joker{
    key = "The_Missing_Piece",
    rarity = 1,
    blueprint_compat = true,
    atlas = "Joker",
    pos = {x = 12, y = 1},
    cost = 4,
    config = {extra = {mult_mod = 10}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult_mod, redeemed_voucher_count() * card.ability.extra.mult_mod}}
    end,
    calculate = function(self, card, context)
        if context.buying_card and context.card.ability.set == "Voucher" then
            G.E_MANAGER:add_event(Event({
                func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_mult',vars={redeemed_voucher_count()* card.ability.extra.mult_mod}}}); return true
                end}))
            return
        end
        if context.joker_main then
            local mult = redeemed_voucher_count() * card.ability.extra.mult_mod
            if mult > 0 then
                return {
                    mult = mult,
                }
            end
        end
    end,
}