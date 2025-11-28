SMODS.Joker:take_ownership("square", {
    rarity = 2,
    cost = 4,
    config = { extra = { chips = 0, chip_mod = 0, repetitions = 1 } },
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and #context.full_hand == 4 then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end,
})