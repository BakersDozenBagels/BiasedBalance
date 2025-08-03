local function lose_up_to(dollars)
    local lose = math.max(0, math.min(G.GAME.dollars - G.GAME.bankrupt_at, dollars))
    if lose ~= 0 then
        ease_dollars(-lose, true)
    end
end

SMODS.Consumable {
    key = 'Conjuration',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 0,
        y = 0
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_double
    end,
    can_use = function(self, card) return true end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                add_tag(Tag('tag_double'))
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
    end
}

SMODS.Consumable {
    key = 'Phantom',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 1,
        y = 0
    },
    cost = 4,
    config = { extra = { pay = 5 } },
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
                lose_up_to(card.ability.extra.pay)
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

SMODS.Consumable {
    key = 'Stain',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 2,
        y = 0
    },
    cost = 4,
    config = { extra = { pay = 10, cards = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards, card.ability.extra.pay } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.extra.cards
    end,
    use = function(self, card, area, copier)
        if not self:can_use(card) then return end

        local conv = {}
        for _, v in pairs(G.hand.highlighted) do
            conv[#conv + 1] = v
        end

        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                lose_up_to(card.ability.extra.pay)
                return true
            end
        }))

        for _, v in ipairs(conv) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    v:set_seal(SMODS.poll_seal({ guaranteed = true }), nil, true)
                    return true
                end
            }))
        end

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}

SMODS.Consumable {
    key = 'Crossroads',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 3,
        y = 0
    },
    cost = 4,
    config = { extra = { pay = 10, cards = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards, card.ability.extra.pay } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.extra.cards
    end,
    use = function(self, card, area, copier)
        if not self:can_use(card) then return end

        local conv = {}
        for _, v in pairs(G.hand.highlighted) do
            conv[#conv + 1] = v
        end

        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                lose_up_to(card.ability.extra.pay)
                return true
            end
        }))

        for _, v in ipairs(conv) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local edition = poll_edition('aura', nil, nil, true, {
                        { name = 'e_foil',       weight = 25 },
                        { name = 'e_holo',       weight = 35 },
                        { name = 'e_negative',   weight = 25 },
                        { name = 'e_polychrome', weight = 15 },
                    })
                    v:set_edition(edition, true)
                    return true
                end
            }))
        end

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}

SMODS.Consumable {
    key = 'Awakening',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 4,
        y = 0
    },
    cost = 4,
    can_use = function(self, card) return true end,
    use = function(self, card, area, copier)
        G.GAME.biasedBalance_awakening = (G.GAME.biasedBalance_awakening or 0) + 1
    end
}

SMODS.Consumable {
    key = 'Sacrifice',
    set = 'Spectral',
    atlas = "Spectrals",
    pos = {
        x = 0,
        y = 1
    },
    cost = 4,
    config = { extra = { dollars = 25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards >= 1 and not G.jokers.cards[1].ability.eternal
    end,
    use = function(self, card, area, copier)
        if not self:can_use(card) then return end

        local slice = G.jokers.cards[1]
        G.E_MANAGER:add_event(Event {
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                slice:start_dissolve()
                ease_dollars(card.ability.extra.dollars)
                return true
            end
        })
    end
}
