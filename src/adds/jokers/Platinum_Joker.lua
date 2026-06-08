SMODS.Joker {
    atlas = "Joker",
    key = "Platinum_Joker",
    pos = {
        x = 11,
        y = 1
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {
        money = 6,
        money_threshold = 69
    } },
    loc_vars = function(self, info_queue, card)
        local vars = { vars = { card.ability.extra.money, card.ability.extra.money_threshold } }
        if card.area and (card.area.config.collection or card.area.config.type == 'shop') then
            vars.key = 'j_biasedBalance_plat_collection'
        end
        return vars
    end,
    calc_dollar_bonus = function(self, card)
        local dollars = math.max(0, G.GAME.dollars + (G.GAME.dollar_buffer or 0))
        if dollars <= card.ability.extra.money_threshold then
            return card.ability.extra.money
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        local dollars = math.max(0, G.GAME.dollars + (G.GAME.dollar_buffer or 0))
        if not from_debuff then
            card.ability.extra.money_threshold = dollars
        end
    end
}