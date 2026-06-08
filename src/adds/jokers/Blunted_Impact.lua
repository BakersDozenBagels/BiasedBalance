SMODS.Joker {
    atlas = "Joker",
    key = "BluntedImpact",
    pos = {
        x = 2,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            x_mult = 3,
        }
    },
    loc_vars = function(self, info_queue, card)
        local name
        if G.GAME.biasedBalance_priorHand == nil then
            name = localize('biasedBalance_none', 'text')
        else
            name = localize(G.GAME.biasedBalance_priorHand, 'poker_hands')
        end
        return { vars = { card.ability.extra.x_mult, name } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual and G.GAME.biasedBalance_priorHand and context.scoring_name ~= G.GAME.biasedBalance_priorHand then
            return { x_mult = card.ability.extra.x_mult }
        end
    end
}

local raw_evaluate_play_after = evaluate_play_after
function evaluate_play_after(name, ...)
    local ret = { raw_evaluate_play_after(name, ...) }
    G.GAME.biasedBalance_priorHand = name
    return unpack(ret)
end

local raw_ease_round = ease_round
function ease_round(...)
    G.GAME.biasedBalance_priorHand = nil
    return raw_ease_round(...)
end