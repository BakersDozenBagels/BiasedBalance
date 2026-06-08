SMODS.Consumable:take_ownership('c_grim', {
    no_collection = true,
	in_pool = function(self, args)
		return false
	end,
})