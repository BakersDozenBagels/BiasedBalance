local polling_playing = false

local raw_get_weight = G.P_CENTERS.e_negative.get_weight
SMODS.Edition:take_ownership("negative", {
    weight = .4,
    get_weight = function(self)
        local mul = polling_playing and 7 or 1
        if G.GAME.selected_back.effect.center.key == "b_black" then
            mul = mul * 4
        end
        return raw_get_weight(self) * mul
    end,
})

local raw_get_weight = G.P_CENTERS.e_foil.get_weight
SMODS.Edition:take_ownership("foil", {
    config = setmetatable({ chips = 65 }, {
        __index = function(t, k)
            if k == 'extra' then return t.chips end
            return rawget(t, k)
        end,
        __newindex = function(t, k, v)
            if k == 'extra' then
                t.chips = v; return
            end
            rawset(t, k, v)
        end,
    }),
    weight = 1.75,
    get_weight = function(self)
        local mul = polling_playing and 2 or 1
        return raw_get_weight(self) * mul
    end,
})

local raw_get_weight = G.P_CENTERS.e_holo.get_weight
SMODS.Edition:take_ownership("holo", {
    weight = 1.75,
    get_weight = function(self)
        local mul = polling_playing and 2 or 1
        return raw_get_weight(self) * mul
    end,
})

local raw_get_weight = G.P_CENTERS.e_polychrome.get_weight
SMODS.Edition:take_ownership("polychrome", {
    weight = .5,
    get_weight = function(self)
        local mul = polling_playing and 2.8 or 1
        return raw_get_weight(self) * mul
    end,
})

local raw_poll_edition = poll_edition
function poll_edition(k, m, n, ...)
    polling_playing = n
    return raw_poll_edition(k, m, k == "wheel_of_fortune", ...)
end

local raw_Card_set_debuff = Card.set_debuff
local drawing = false
function Card:set_debuff(should, ...)
    local prev = self.debuff
    raw_Card_set_debuff(self, should, ...)
    local do_draw = prev and not self.debuff and self.edition and self.edition.card_limit and self.area == G.hand
    if do_draw then
        G.hand.config.real_card_limit = G.hand.config.real_card_limit + self.edition.card_limit
        G.hand.config.card_limit = G.hand.config.card_limit + self.edition.card_limit
        if not drawing then
            drawing = true
            G.E_MANAGER:add_event(Event {
                func = function()
                    G.FUNCS.draw_from_deck_to_hand()
                    drawing = false
                    return true
                end
            })
        end
    end
end
