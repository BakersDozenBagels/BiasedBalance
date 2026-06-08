--[[SMODS.Joker {
    atlas = "Joker",
    key = "Cinemaphile",
    pos = {
        x = 11,
        y = 2
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_double', set = 'Voucher' }
        return { vars = { localize { type = 'name_text', set = 'Voucher', key = 'tag_double' } } }
    end,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            local voucher_key = get_next_voucher_key(true)
            G.GAME.current_round.voucher.spawn[voucher_key] = true
            G.GAME.current_round.voucher[#G.GAME.current_round.voucher + 1] = voucher_key
            if G.STATE == G.STATES.SHOP or G.TAROT_INTERRUPT == G.STATES.SHOP then
                local vcard = SMODS.add_voucher_to_shop(voucher_key)
                vcard.from_tag = true
            end
        end
    end
}]]--
SMODS.Joker {
    atlas = "Joker",
    key = "Cinemaphile",
    pos = {
        x = 11,
        y = 2
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_voucher', set = 'Tag' }
        return { vars = { localize { type = 'name_text', set = 'Tag', key = 'tag_voucher' } } }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_voucher'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end
}