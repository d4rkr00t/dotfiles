-- local safe_require = require("ssysoev.utils.safe-require")
-- safe_require({ "Comment", "ts_context_commentstring.integrations.comment_nvim" }, function(mods)
-- 	local comment = mods.Comment
-- 	local tsContextCommentString = mods["ts_context_commentstring.integrations.comment_nvim"]
-- 	comment.setup({
-- 		pre_hook = tsContextCommentString.create_pre_hook(),
-- 	})
-- end)

local safe_require = require("ssysoev.utils.safe-require")
safe_require({ "Comment" }, function(mods)
	local comment = mods.Comment
	comment.setup({
	})
end)
