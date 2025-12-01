local b_std = SMODS.Booster {
    key = 'GigaStandard',
    no_collection = true,
    pos = { x = 2, y = 7 },
    config = {
        extra = 8,
        choose = 4
    },
    weight = 0,
    loc_vars = function()
        return { vars = { 8, 4 } }
    end,
    create_card = function(self, card, i)
        return G.P_CENTERS.p_standard_normal_1:create_card(card, i)
    end,
    in_pool = function() return false end
}

SMODS.Tag:take_ownership("standard", {
    config = {
        choose = 4,
        from = 8,
    },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_biasedBalance_GigaStandard
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