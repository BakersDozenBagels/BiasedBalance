local function contains(table_, value)
    for _, v in pairs(table_) do
        if v == value then
            return true
        end
    end

    return false
end

local function add_unique_value(tbl, value)
  for _, v in pairs(tbl) do
    if v == value then
      return
    end
  end

  table.insert(tbl, value)
end

local function check_enhancements()
    local enhancements = {}
  if context.scored_hand then
    for _, v in pairs(context.scored_hand) do
        for k, _ in pairs(SMODS.get_enhancements(v)) do
          add_unique_value(enhancements, k)
        end
    end
  end
  local total =
      (enhancements and #enhancements or 0)

  return total
end

SMODS.Joker:take_ownership("ExtraCredit_jokalisa", { 
    loc_txt = {
        ['name'] = 'Joka Lisa',
        ['text'] = {
            [1] = 'Gains {X:mult,C:white}X#2#{} Mult the',
            [2] = 'first time a {C:attention}unique',
            [3] = '{C:attention}enhancement{} is scored',
            [4] = 'per round',
            [5] = '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})'
        }
    },
    config = {
        extra = {
            Xmult = 1,
            Xmult_mod = 0.1,
            enhancements_scored = {}
        }
    },
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local activated = false
            for _, playing_card in ipairs(context.scoring_hand) do
                for k, v in pairs(SMODS.get_enhancements(playing_card)) do
                    if v then
                        if not contains(card.ability.extra.enhancements_scored, k) then
                            card.ability.extra.enhancements_scored[#card.ability.extra.enhancements_scored+1] = k
                            activated = true
                        end
                    end
                end
            end
            if activated then
                card.ability.extra.Xmult = card.ability.extra.Xmult + (card.ability.extra.Xmult_mod*#card.ability.extra.enhancements_scored)
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                    card = card,
                    colour = G.C.RED
                }
            end

        elseif context.cardarea == G.jokers and context.joker_main and card.ability.extra.Xmult > 1 then
            return{
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                Xmult_mod = card.ability.extra.Xmult
            }
        end
        if context.end_of_round then
            card.ability.extra.enhancements_scored = {}
        end
    end
})