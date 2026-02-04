SMODS.Voucher:take_ownership('retcon', {
    config = {
        },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                extra = 10,
            }
        }  
        end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss then
            G.GAME.Biased_Balance.can_reroll_shop = true
        end
    end
})
--local _, voucher = SMODS.find_card('v_retcon')

    --if voucher --[[and not voucher.ability.extra.rerolled]] then

--voucher.ability.extra.rerolled = true
    --end


local reroll_shopref = G.FUNCS.reroll_shop
function G.FUNCS.reroll_shop(e)
    local ret = reroll_shopref(e)

    for _, v in ipairs(SMODS.find_card('v_retcon')) do
        if G.GAME.Biased_Balance.can_reroll_shop then
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
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    if #G.shop_vouchers.cards > 0 then
                        for i = #G.shop_vouchers.cards, 1, -1 do
                            local c = G.shop_vouchers:remove_card(G.shop_vouchers.cards[i])
                            c:remove()
                            c = nil
                        end
                        G.ARGS.voucher_tag = G.ARGS.voucher_tag or {}
                        local voucher_key = get_next_voucher_key(true)
                        G.ARGS.voucher_tag[voucher_key] = true
                        G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
                        local card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w/2,
                        G.shop_vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[voucher_key],{bypass_discovery_center = true, bypass_discovery_ui = true})
                        create_shop_card_ui(card, 'Voucher', G.shop_vouchers)
                        card:start_materialize()
                        G.shop_vouchers:emplace(card)
                        G.ARGS.voucher_tag = nil
                        
                    end
                return true
                end
            }))
            G.E_MANAGER:add_event(Event({ func = function() save_run(); return true end}))
            G.GAME.Biased_Balance.can_reroll_shop = false
            break
        end
    end
    return ret
end