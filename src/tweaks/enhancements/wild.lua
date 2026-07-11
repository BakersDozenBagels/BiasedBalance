local raw_Card_set_ability = Card.set_ability
function Card:set_ability(...)
    if self.config.center and self.config.center.unset_ability and self.ability then
        self.config.center:unset_ability(self)
    end
    raw_Card_set_ability(self, ...)
end

local peafowl_override = 1
local function peafowl()
    local val = peafowl_override
    if not G.jokers then return val end
    for _, v in pairs(G.jokers.cards) do
        if v.config.center.key == 'j_biasedBalance_Peafowl' and not v.debuff then
            val = val * (1 + v.ability.extra)
        end
    end
    return val
end

SMODS.Enhancement:take_ownership("m_mult", {
    config = { extra = 4 },
    effect = "biasedBalance",
    loc_vars = function(_, _, card)
        return { vars = { SMODS.signed(card.ability.extra + (G.GAME.Biased_Balance.has_peafowl and 2 or 0)) } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return { mult = card.ability.extra + (G.GAME.Biased_Balance.has_peafowl and 2 or 0) }
        end
    end,
})

SMODS.Enhancement:take_ownership("m_bonus", {
    config = { extra = 30 },
    effect = "biasedBalance",
    loc_vars = function(_, _, card)
        return { vars = { SMODS.signed(card.ability.extra + (G.GAME.Biased_Balance.has_peafowl and 15 or 0)) } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return { chips = card.ability.extra + (G.GAME.Biased_Balance.has_peafowl and 15 or 0) }
        end
    end,
})

SMODS.Enhancement:take_ownership("m_glass", {
    config = { extra = { x_mult = 1, odds = 4 } },
    effect = "biasedBalance",
    loc_vars = function(_, _, card)
        return { vars = { 1 + card.ability.extra.x_mult + (G.GAME.Biased_Balance.has_peafowl and 0.5 or 0), SMODS.get_probability_vars(
                    card,
                    1 * (G.GAME.Biased_Balance.has_peafowl and 2 or 0),
                    card.ability.extra.odds,
                    'j_biasedBalance_glass',
                    false) } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return { x_mult = 1 + card.ability.extra.x_mult + (G.GAME.Biased_Balance.has_peafowl and 0.5 or 0) }
        end
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card
            and SMODS.pseudorandom_probability(
                    card, "glass",
                    1 * (G.GAME.Biased_Balance.has_peafowl and 2 or 0),
                    card.ability.extra.odds,
                    'j_biasedBalance_glass',
                    false) then
            return { remove = true }
        end
    end,
})

SMODS.Enhancement:take_ownership("m_stone", {
    no_suit = true,
    no_rank = true,
    always_scores = true,
    replace_base_card = true,
    config = { extra = 50 },
    effect = "biasedBalance",
    loc_vars = function(_, _, card)
        return { vars = { SMODS.signed(card.ability.extra + (G.GAME.Biased_Balance.has_peafowl and 25 or 0)) } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return { chips = card.ability.extra + (G.GAME.Biased_Balance.has_peafowl and 25 or 0) }
        end
    end,
})

SMODS.Enhancement:take_ownership("m_steel", {
    config = { extra = 0.5 },
    effect = "biasedBalance",
    loc_vars = function(_, _, card)
        return { vars = { 1 + card.ability.extra + (G.GAME.Biased_Balance.has_peafowl and .25 or 0) } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.hand then
            return { x_mult = 1 + card.ability.extra + (G.GAME.Biased_Balance.has_peafowl and .25 or 0) }
        end
    end,
})

local raw_Card_get_h_dollars = Card.get_h_dollars
function Card:get_h_dollars()
    return raw_Card_get_h_dollars(self) +
        (not self.debuff and self.config.center.get_h_dollars and self.config.center:get_h_dollars(self) or 0)
end

SMODS.Enhancement:take_ownership("m_gold", {
    config = { extra = 3 },
    effect = "biasedBalance",
    loc_vars = function(_, _, card)
        return { vars = { SMODS.signed_dollars(math.ceil(card.ability.extra + (G.GAME.Biased_Balance.has_peafowl and 2 or 0))) } }
    end,
    get_h_dollars = function(self, card)
        return math.ceil(card.ability.extra + (G.GAME.Biased_Balance.has_peafowl and 2 or 0))
    end,
})

SMODS.Enhancement:take_ownership("m_lucky", {
    config = { extra = { mult = 20, dollars = 20, mult_odds = 5, dollars_odds = 15 } },
    effect = "biasedBalance",
    loc_vars = function(self, info_queue, card)
        local mult_numerator, mult_denominator = SMODS.get_probability_vars(card, 1 * (G.GAME.Biased_Balance.has_peafowl and 2 or 1), card.ability.extra.mult_odds,
            'luck_mult')
        local dollars_numerator, dollars_denominator = SMODS.get_probability_vars(card, 1 * (G.GAME.Biased_Balance.has_peafowl and 2 or 1),
            card.ability.extra.dollars_odds, 'luck_money')
        return { vars = { mult_numerator, dollars_numerator, card.ability.extra.mult, mult_denominator, card.ability.extra.dollars, dollars_denominator } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local ret = {}
            if SMODS.pseudorandom_probability(card, 'luck_mult', 1 * (G.GAME.Biased_Balance.has_peafowl and 2 or 1), card.ability.extra.mult_odds) then
                card.lucky_trigger = true
                ret.mult = card.ability.extra.mult
            end
            if SMODS.pseudorandom_probability(card, 'luck_money', 1 * (G.GAME.Biased_Balance.has_peafowl and 2 or 1), card.ability.extra.dollars_odds) then
                card.lucky_trigger = true
                ret.dollars = card.ability.extra.dollars
            end
            return ret
        end
    end,
})