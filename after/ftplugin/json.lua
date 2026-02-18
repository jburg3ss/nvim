vim.cmd("set filetype=json")
vim.cmd("setlocal tabstop=2 shiftwidth=2 expandtab")


vim.api.nvim_create_user_command("JsonCleanPretty", function(opts)
	local cmd = [[perl -0777 -pe 's/^.*?(\{)/$1/s' | jq . 2>/dev/null]]
	if opts.range == 0 then
		vim.cmd("%!" .. cmd)
	else
		vim.cmd(string.format("%d,%d!%s", opts.line1, opts.line2, cmd))
	end
end, { range = true, desc = "Force JSON cleanup + pretty print" })
