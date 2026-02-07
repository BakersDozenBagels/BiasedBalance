local b_std = SMODS.Booster {
    key = 'HyperArcana',
    no_collection = true,
    draw_hand = true,
    config = {
        extra = 5,
        choose = 3
    },
    atlas = "Boosters",
	pos = { x = 1, y = 0 },
    weight = 0,
    loc_vars = function()
        return { vars = { 3, 5 } }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {
                set = "Spectral",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "vremade_ar2"
            }
        else
            _card = {
                set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "vremade_ar2"
            }
        end
        return _card
    end,
    in_pool = function() return false end
}

SMODS.Tag:take_ownership("charm", {
    config = {
        choose = 3,
        from = 5,
    },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_biasedBalance_HyperArcana
        return { vars = { self.config.choose, self.config.from } }
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            tag:yep('+', G.C.PURPLE, function()
                local booster = Card(G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2, G.CARD_W * 1.27, G.CARD_H * 1.27, G.P_CARDS.empty,
                    b_std, { bypass_discovery_center = true, bypass_discovery_ui = true })
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                return true
            end)
            tag.triggered = true
            return true
        end
    end
})