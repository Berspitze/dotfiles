return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- use latest release, remove to use latest commit
	opts = {
		legacy_commands = false, -- this will be removed in 4.0.0
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/Obsidian Vault/personal/",
			},
			-- {
			-- 	name = "work",
			-- 	path = "~/Documents/Obsidian Vault/work",
			-- },
		},
	},
}
