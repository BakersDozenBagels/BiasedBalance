SMODS.Joker:take_ownership("dusk", { 
    rarity = 2,
    cost = 6,
    perishable_compat = false,
    config = {
        extra = {
            a_mult = 1,
            s_mult = 3,
            mult = 0,
            bad = false
        }
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = {  
                card.ability.extra.mult,
                card.ability.extra.a_mult,
                card.ability.extra.s_mult
            } }
        end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            card.ability.extra.bad = false
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:is_suit("Diamonds") or playing_card:is_suit("Hearts") then
                    card.ability.extra.bad = true
                    break
                end
            end
            if card.ability.extra.bad then
                card.ability.extra.mult = math.max(card.ability.extra.mult - card.ability.extra.s_mult, 0)
            end
        end

        if context.individual and context.cardarea == G.play and not context.blueprint then
            if not card.ability.extra.bad and (context.other_card:is_suit("Spades") or context.other_card:is_suit("Clubs")) then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_mult
            end
        end

        if context.joker_main then
            card.ability.extra.bad = false
            return {
                mult = card.ability.extra.mult
            }
        end
    end
})

