SMODS.Joker {
    atlas = "Joker",
    key = "Bittergiggle",
    pos = {
        x = 10,
        y = 7
    },
    rarity = 4,
    cost = 20,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { rarity = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    add_to_deck = function(self, card, from_debuff)
        card:set_edition('e_negative')
    end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and type(context.other_card) == "table" and
        type(context.other_card.is) == "function" and context.other_card:is(Card) then
            if context.other_card.config.center.rarity == card.ability.extra.rarity then
                return {
                repetitions = 1
                }
            end
        end
  end,
}