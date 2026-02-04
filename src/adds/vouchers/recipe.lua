SMODS.Voucher {
    key = 'recipe',
    atlas = "Vouchers",
    pos = { x = 0, y = 0 },
    config = { extra = { pack_size = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.pack_size } }
    end,
    redeem = function(self, card)
        if G.STATE == G.STATES.SHOP then
        G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    if #G.shop_booster.cards > 0 then
                        for i = #G.shop_booster.cards, 1, -1 do
                            local c = G.shop_booster:remove_card(G.shop_booster.cards[i])
                            c:remove()
                            c = nil
                        end
                    end

                    G.GAME.current_round.used_packs = G.GAME.current_round.used_packs or {}
                    for i = #G.GAME.current_round.used_packs+1, #G.GAME.current_round.used_packs+2 do
                        if not G.GAME.current_round.used_packs[i] then
                            G.GAME.current_round.used_packs[i] = get_pack('shop_pack').key
                        end

                        if G.GAME.current_round.used_packs[i] ~= 'USED' then 
                            local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,
                            G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.used_packs[i]], {bypass_discovery_center = true, bypass_discovery_ui = true})
                            create_shop_card_ui(card, 'Booster', G.shop_booster)
                            card.ability.booster_pos = i
                            card:start_materialize()
                            G.shop_booster:emplace(card)
                        end
                    end
                return true
                end
            }))
        end
    end
}

local set_ability_hook = Card.set_ability
function Card:set_ability(...)
    local ret = { set_ability_hook(self, ...) }
    if self.ability.set == "Booster" then
        for _, v in ipairs(SMODS.find_card('v_biasedBalance_recipe')) do
            self.ability.extra = self.ability.extra + 1
        end
    end
    return unpack(ret)
end