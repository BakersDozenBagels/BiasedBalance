local no_debuff = {
    bl_goad = true,
    bl_head = true,
    bl_club = true,
    bl_window = true,
}

SMODS.current_mod.set_debuff = function(card)
    if card.config.center.key == 'm_wild' and no_debuff[G.GAME.blind.config.blind.key] then
        return 'prevent_debuff'
    end
end
