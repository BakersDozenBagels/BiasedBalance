SMODS.Booster:take_ownership_by_kind('Spectral', {
    get_weight = function(self)
        if G.GAME.selected_back.effect.center.key == "b_ghost" then
            return self.weight * 3
        end
        return self.weight
    end
}, true)
