local no_debuff = {
    -- ALL THE BLINDS!
    bl_goad = true,
    bl_head = true,
    bl_club = true,
    bl_window = true,
    -- Bunco
    bl_bunc_final_crown = true,
    -- Unik
    bl_unik_collapse = true,
    -- Minty
    bl_minty_thenip = true,
    bl_minty_thenipdx = true,
    -- Music Suit
    bl_MusicalSuit_deaf = true,
    -- Balatro Goes Kino
    bl_kino_loki = true,
    -- More Fluff
    bl_mf_club_dx = true,
    bl_mf_goad_dx = true,
    bl_mf_head_dx = true,
    bl_mf_window_dx = true,
    -- Furlatro
    bl_fur_meteorblind = true,
    -- Madcap
    bl_rgmc_bottle = true,
    bl_rgmc_sword = true,
    -- Aikoyoris-Shenanigans
    bl_akyrs_final_razzle_raindrop = true,
    -- Entropy
    bl_entr_eta = true,
    -- Cruel Blinds
    bl_cruel_day = true,
    bl_cruel_night = true,
}

SMODS.current_mod.set_debuff = function(card)
    if card.config.center.key == 'm_wild' and no_debuff[G.GAME.blind.config.blind.key] then
        return 'prevent_debuff'
    end
end
