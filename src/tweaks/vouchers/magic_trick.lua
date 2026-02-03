-- Referenced in lovely.toml
function BiasedBalance.magic_trick()
    return (G.GAME.used_vouchers["v_magic_trick"] and pseudorandom(pseudoseed('illusion')) > (G.GAME.used_vouchers["v_illusion"] and 0.4 or 0.6)) and
        'Enhanced' or 'Base'
end