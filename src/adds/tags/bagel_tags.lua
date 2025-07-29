SMODS.ObjectType {
    key = 'biasedBalance_UtilityJoker',
    default = 'j_chaos',
    cards = {
        j_chaos = true,
        j_space = true,
        j_splash = true,
        j_juggler = true,
        j_drunkard = true,
        j_four_fingers = true,
        j_pareidolia = true,
        j_burglar = true,
        j_shortcut = true,
        j_midas_mask = true,
        j_troubadour = true,
        j_smeared = true,
        j_ring_master = true,
        j_merry_andy = true,
        j_oops = true,
        j_hanging_chad = true,
        j_mime = true,
        j_hack = true,
        j_selzer = true,
        j_sock_and_buskin = true,
        j_biasedBalance_Spooky = true,
        j_biasedBalance_Peafowl = true,
        j_biasedBalance_UpsideDown = true,
        j_biasedBalance_InTheHole = true,
        j_biasedBalance_Chimera = true,
        j_biasedBalance_Minstrel = true,
        j_biasedBalance_Poacher = true,
        j_burnt = true,
        j_astronomer = true,
    },
    inject = function(self)
        SMODS.ObjectType.inject(self)
        for k in pairs(self.cards) do
            for k2, v in pairs(G.P_CENTERS) do
                if k == k2 then
                    self:inject_card(v)
                    break
                end
            end
        end
    end
}

-- F.ipairs(G.P_CENTER_POOLS.biasedBalance_UtilityJoker):map(function(x) return x.key end):conjoin(', ')

local b_ut = SMODS.Booster {
    key = 'Utility',
    no_collection = true,
    pos = { x = 0, y = 8 },
    config = {
        extra = 4,
        choose = 2
    },
    weight = 0,
    draw_hand = false,
    select_card = 'jokers',
    create_card = function(self, card, i)
        return { set = 'biasedBalance_UtilityJoker' }
    end,
    in_pool = function() return false end
}

SMODS.Tag {
    key = 'Utility',
    atlas = 'Tags',
    pos = { x = 1, y = 0 },
    min_ante = 2,
    loc_vars = function(self, info_queue, card)
        return { vars = { b_ut.config.choose, b_ut.config.extra } }
    end,
    apply = function(self, card, context)
        if context.type == 'new_blind_choice' then
            card:yep('+', G.C.PURPLE, function()
                local booster = Card(G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2, G.CARD_W * 1.27, G.CARD_H * 1.27, G.P_CARDS.empty,
                    b_ut, { bypass_discovery_center = true, bypass_discovery_ui = true })
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                return true
            end)
            card.triggered = true
            return true
        end
    end
}

SMODS.Consumable {
    key = 'Sacrifice2',
    set = 'Spectral',
    atlas = 'Spectrals',
    pos = { x = 1, y = 1 },
    no_collection = true,
    loc_vars = function()
        return { vars = { 4, 2 } }
    end,
    in_pool = function() return false end,
    can_use = function()
        local count = #G.hand.highlighted
        return count > 0 and count <= 4
    end,
    use = function(self, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        local cards = {}
        for k, v in pairs(G.hand.highlighted) do cards[#cards + 1] = v end
        table.sort(cards, function(a, b) return a.T.x < b.T.x end)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                for i, v in ipairs(cards) do
                    if i <= 2 then
                        if SMODS.shatters(cards[i]) then
                            cards[i]:shatter()
                        else
                            cards[i]:start_dissolve(nil, i == #cards)
                        end
                    else
                        cards[i]:set_edition(poll_edition('Sacrifice', nil, nil, true, {
                            { name = 'e_foil',       weight = 30 },
                            { name = 'e_holo',       weight = 22.5 },
                            { name = 'e_negative',   weight = 32.5 },
                            { name = 'e_polychrome', weight = 15 },
                        }), true)
                    end
                end
                return true
            end
        }))
    end
}

local b_sac = SMODS.Booster {
    key = 'Sacrifice',
    no_collection = true,
    pos = { x = 0, y = 4 },
    config = {
        extra = 1,
        choose = 1
    },
    weight = 0,
    draw_hand = true,
    loc_vars = function()
        return { vars = { 4, 2 } }
    end,
    create_card = function(self, card, i)
        return { key = 'c_biasedBalance_Sacrifice2' }
    end,
    in_pool = function() return false end
}

SMODS.Tag {
    key = 'Sacrifice',
    atlas = 'Tags',
    pos = { x = 0, y = 0 },
    min_ante = 0,
    loc_vars = function()
        return { vars = { 4, 2 } }
    end,
    apply = function(self, card, context)
        if context.type == 'new_blind_choice' then
            card:yep('+', G.C.PURPLE, function()
                local booster = Card(G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2, G.CARD_W * 1.27, G.CARD_H * 1.27, G.P_CARDS.empty,
                    b_sac, { bypass_discovery_center = true, bypass_discovery_ui = true })
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                return true
            end)
            card.triggered = true
            return true
        end
    end
}

