return {
	-- supports "#??????" & "0x??????"
    "catgoose/nvim-colorizer.lua",
    opts = {
        filetypes = { "*" },
        options = {
            parsers = {
                hex = {
                    default = true,
                    aarrggbb = true,
                },
                custom = {
                    {
                        name = "hex_0x_rgb",
                        parse = function(ctx)
                            local s = ctx.line:sub(ctx.col)
                            local hex = s:match("^0x(%x%x%x%x%x%x)%f[^%x]")
                            if hex then
                                return 8, hex
                            end
                        end,
                    },
                },
            },
            display = {
                mode = "background",
            },
        },
    },
}
