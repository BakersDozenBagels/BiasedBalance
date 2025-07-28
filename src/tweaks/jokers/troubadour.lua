local function two_pairs(a, b)
    local next, t, k = pairs(a)
    local done, v = false, nil
    return function()
        k, v = next(t, k)
        if k == nil and not done then
            done = true
            next, t, k = pairs(b)
            k, v = next(b)
        end
        return k, v
    end
end

local raw_G_FUNCS_can_discard = G.FUNCS.can_discard
function G.FUNCS.can_discard(e)
    for k, v in two_pairs(SMODS.find_card("j_troubadour"), SMODS.find_card("j_biasedBalance_Minstrel")) do
        if v.ability and #G.hand.highlighted > v.ability.extra.discard_size then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
            return
        end
    end
    raw_G_FUNCS_can_discard(e)
end

SMODS.Joker:take_ownership("troubadour", {
    config = { extra = { h_size = 2, h_plays = 0, discard_size = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size, card.ability.extra.discard_size } }
    end
})
