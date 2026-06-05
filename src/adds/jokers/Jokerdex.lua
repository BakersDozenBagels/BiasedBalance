SMODS.Joker {
    atlas = "Joker",
    key = "Jokerdex",
    pos = {
        x = 0,
        y = 1
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            mult = 0,
            a_mult = 2,
            seen = {}
        } 
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME.num_jokers_this_run then
            card.ability.extra.mult = (card.ability.extra.a_mult * G.GAME.num_jokers_this_run)
        end
        return { 
        vars = { 
            card.ability.extra.a_mult,
            card.ability.extra.mult
        } 
    }
    end,
    calculate = function(self, card, context)
        G.GAME.num_jokers_this_run = G.GAME.num_jokers_this_run or 0
        if context.joker_main then
            return {
                mult = card.ability.extra.a_mult * G.GAME.num_jokers_this_run
            }
        end
        if context.added_unique_joker then
            return {
                message = localize('k_upgrade_ex')
            }
        end
    end
}

local addref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    addref(self, from_debuff)
    if self.ability.set == 'Joker' then
        G.GAME.jokers_this_run = G.GAME.jokers_this_run or {}
        G.GAME.num_jokers_this_run = G.GAME.num_jokers_this_run or 0
        if not G.GAME.jokers_this_run[self.config.center.key] then
            G.GAME.jokers_this_run[self.config.center.key] = true
            G.GAME.num_jokers_this_run = G.GAME.num_jokers_this_run + 1
            SMODS.calculate_context({added_unique_joker = true})
        end
    end
end