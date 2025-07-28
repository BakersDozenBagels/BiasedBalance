-- Referenced in lovely.toml
function BiasedBalance.magic_trick()
    return (G.GAME.used_vouchers["v_magic_trick"] and pseudorandom(pseudoseed('illusion')) > (G.GAME.used_vouchers["v_illusion"] and 0.4 or 0.6)) and
        'Enhanced' or 'Base'
end

function BiasedBalance.illusion(card, type)
    if type ~= 'Base' and type ~= 'Enhanced' then return end
    local enhanced = card.config.center.key ~= 'c_base'
    local edition = poll_edition('illusion', G.GAME.edition_rate * 2, true)
    local seal = SMODS.poll_seal { key = 'illusion' }

    if G.GAME.used_vouchers["v_illusion"] and not enhanced then
        local i = 1
        while not edition and not seal do
            edition = poll_edition('illusion_resample' .. i, G.GAME.edition_rate, true)
            seal = SMODS.poll_seal { key = 'illusion' }
            i = i + 1
        end
    end

    if edition then
        card:set_edition(edition, true)
    end
    if seal then
        card:set_seal(seal, true)
    end
end

SMODS.Booster:take_ownership_by_kind('Standard', {
    create_card = function(self, card, i)
        local _edition = poll_edition('standard_edition' .. G.GAME.round_resets.ante, 2, true)
        local _seal = SMODS.poll_seal({ mod = 10 })
        local set = (pseudorandom(pseudoseed('stdset' .. G.GAME.round_resets.ante)) > 0.6) and "Enhanced" or "Base"

        if G.GAME.used_vouchers["v_illusion"] then
            while not _edition and not _seal and set == "Base" do
                _edition = poll_edition('standard_edition' .. G.GAME.round_resets.ante, 2, true)
                _seal = SMODS.poll_seal({ mod = 10 })
                set = (pseudorandom(pseudoseed('stdset' .. G.GAME.round_resets.ante)) > 0.6) and "Enhanced" or "Base"
            end
        end

        return {
            set = set,
            edition = _edition,
            seal = _seal,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append =
            "sta"
        }
    end,
})