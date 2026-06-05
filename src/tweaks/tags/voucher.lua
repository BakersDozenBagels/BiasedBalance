local function bbalance_add_voucher_to_shop(key, dont_save)
    if key then assert(G.P_CENTERS[key], "Invalid voucher key: "..key) else
        key = get_next_voucher_key()
        if not dont_save then
            G.GAME.current_round.voucher.spawn[key] = true
            G.GAME.current_round.voucher[#G.GAME.current_round.voucher + 1] = key
        end
    end
    local card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w/2,
        G.shop_vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[key],{bypass_discovery_center = true, bypass_discovery_ui = true})
        card.cost = card.cost - 5
        card.shop_voucher = true
        create_shop_card_ui(card, 'Voucher', G.shop_vouchers)
        card:start_materialize()
        G.shop_vouchers:emplace(card)
        G.shop_vouchers.config.card_limit = #G.shop_vouchers.cards
        return card
end

SMODS.Tag:take_ownership("voucher", {
    apply = function(self, tag, context)
        if context.type == 'voucher_add' then
            tag:yep('+', G.C.SECONDARY_SET.Voucher, function()
                local voucher = bbalance_add_voucher_to_shop()
                voucher.from_tag = true
                return true
            end)
            tag.triggered = true
        end
    end
})