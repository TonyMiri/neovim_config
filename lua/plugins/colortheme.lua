return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	opts = {
		compile = false,
		transparent = true,
		theme = "dragon",
		background = {
			dark = "dragon",
		},
		colors = {
			palette = {
				-- Enhanced vibrant colors for dragon theme
				dragonWhite = "#FFFFFF", -- Brighter white
				dragonBlue2 = "#7FB4FF", -- Brighter blue for functions
				dragonViolet = "#BB9AFF", -- More vibrant violet for keywords
				dragonPink = "#FF7EB6", -- Brighter pink
				dragonGreen2 = "#ABEC76", -- Brighter green for strings
				dragonOrange = "#FFAD66", -- More vibrant orange
				dragonYellow = "#FFD68A", -- Brighter yellow
				dragonRed = "#FF6666", -- Brighter red
				dragonAqua = "#85FBFF", -- Brighter aqua for types
				dragonTeal = "#2BFFD2", -- Brighter teal
				dragonAsh = "#768390", -- Keep comments subtle but readable
				dragonGray = "#D3BAF5", -- More colorful parameter color
				dragonGray2 = "#CCCCCC", -- Brighter punctuation
			},
		},
		overrides = function(colors)
			return {
				-- Custom comment color
				Comment = { fg = "#009a9a", italic = true },

				-- Make text more vibrant in transparent background
				Normal = { fg = colors.palette.dragonWhite, bg = "NONE" },
				NormalFloat = { fg = colors.palette.dragonWhite, bg = "NONE" },

				-- Make code elements more obvious
				Identifier = { fg = colors.palette.dragonYellow, bold = false },
				Function = { fg = colors.palette.dragonBlue2, bold = true },
				Type = { fg = colors.palette.dragonAqua, bold = true },
				Keyword = { fg = colors.palette.dragonViolet, bold = true },
				Statement = { fg = colors.palette.dragonViolet, bold = true },
				String = { fg = colors.palette.dragonGreen2 },
				Number = { fg = colors.palette.dragonPink, bold = true },
				Boolean = { fg = colors.palette.dragonOrange, bold = true },
				Operator = { fg = colors.palette.dragonRed, bold = true },

				-- Specific Python improvements
				["@variable.python"] = { fg = colors.palette.dragonWhite },
				["@function.python"] = { fg = colors.palette.dragonBlue2, bold = true },
				["@parameter.python"] = { fg = colors.palette.dragonGray },
				["@keyword.python"] = { fg = colors.palette.dragonViolet, bold = true },
				["@include.python"] = { fg = colors.palette.dragonViolet, bold = true },
				["@namespace.python"] = { fg = colors.palette.dragonAqua },

				-- Import statements
				["@include"] = { fg = colors.palette.dragonViolet, bold = true },
				["@namespace"] = { fg = colors.palette.dragonTeal },

				-- Make constants stand out
				["@constant"] = { fg = colors.palette.dragonOrange, bold = true },

				-- Treesitter enhancements for general code
				["@property"] = { fg = colors.palette.dragonTeal },
				["@field"] = { fg = colors.palette.dragonTeal },
				["@constructor"] = { fg = colors.palette.dragonYellow, bold = true },
			}
		end,
		theme = "dragon", -- Using dragon theme with our custom colors
		terminalColors = true,
	},
	config = function(_, opts)
		require("kanagawa").setup(opts)
		vim.cmd("colorscheme kanagawa")
	end,
}
