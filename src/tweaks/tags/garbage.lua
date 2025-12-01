SMODS.Tag:take_ownership("garbage", {
    no_collection = true,
	in_pool = function(self, args)
		return false
	end,
})