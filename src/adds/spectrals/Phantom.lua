SMODS.Consumable {
    key = 'Phantom',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 1,
        y = 0
    },
    cost = 4,
    config = { extra = { pay = 10 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_voucher
        return { vars = { card.ability.extra.pay } }
    end,
    can_use = function(self, card) return true end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag('tag_voucher')
                add_tag(tag)
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                BiasedBalance.lose_up_to(card.ability.extra.pay)
                if G.shop_vouchers then
                    G.E_MANAGER:add_event(Event {
                        func = function()
                            for i = 1, #G.GAME.tags do
                                G.GAME.tags[i]:apply_to_run({ type = 'voucher_add' })
                            end
                            return true
                        end
                    })
                end
                return true
            end
        }))
    end
}