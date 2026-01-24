SMODS.Joker {
    atlas = "Joker",
    key = "Spice",
    pos = {
        x = 12,
        y = 6
    },
    rarity = 3,
    cost = 8,
    pools = { Utility = true },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { reps = 1, suit = nil } },
    loc_vars = function(self, info_queue, card)
        local current_suit = card.ability.extra.suit and card.ability.extra.suit or "Spades"
        return {vars = {localize(current_suit, 'suits_singular'), colours = {G.C.SUITS[current_suit]}}}
    end,
    set_ability = function(self, card, initial, delay_sprites)
	    local tuxedo_suits = {}
		for k, suit in pairs(SMODS.Suits) do
            if
                (type(suit.in_pool) ~= "function" or suit:in_pool({ rank = "" }))
            then
                tuxedo_suits[#tuxedo_suits + 1] = k
            end
        end
        local tuxedo_card = pseudorandom_element(tuxedo_suits, pseudoseed('Spice' .. G.GAME.round_resets.ante))
		card.ability.extra.suit = tuxedo_card
	end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and context.other_card:is_suit(card.ability.extra.suit) then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.reps,
                card = card
            }
        end
    end,
}