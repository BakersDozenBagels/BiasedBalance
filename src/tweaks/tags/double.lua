SMODS.Tag:take_ownership("double", {
    apply = function(self, tag, context)
        if context.type == 'tag_add' and context.tag.key == 'tag_boss' then return true end
    end
}, true)