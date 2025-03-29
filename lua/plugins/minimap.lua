return {
	"Isrothy/neominimap.nvim",
	version = "v3.*.*",
	enabled = true,
	lazy = false,
	keys = {
		{ "<leader>nm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
		{ "<leader>no", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
		{ "<leader>nc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
		{ "<leader>nr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },
		{ "<leader>nwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
		{ "<leader>nwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
		{ "<leader>nwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
		{ "<leader>nwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },
		{ "<leader>ntt", "<cmd>Neominimap tabToggle<cr>", desc = "Toggle minimap for current tab" },
		{ "<leader>ntr", "<cmd>Neominimap tabRefresh<cr>", desc = "Refresh minimap for current tab" },
		{ "<leader>nto", "<cmd>Neominimap tabOn<cr>", desc = "Enable minimap for current tab" },
		{ "<leader>ntc", "<cmd>Neominimap tabOff<cr>", desc = "Disable minimap for current tab" },
		{ "<leader>nbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
		{ "<leader>nbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
		{ "<leader>nbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
		{ "<leader>nbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },
		{ "<leader>nf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
		{ "<leader>nu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
		{ "<leader>ns", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
	},
	init = function()
		-- Set basic options
		vim.opt.wrap = false
		vim.opt.sidescrolloff = 36
		vim.opt.updatetime = 300

		local word_highlights = {}

		-- Create word highlights handler
		local word_handler = {
			name = "Word Highlights",
			mode = "line",
			namespace = vim.api.nvim_create_namespace("neominimap_word"),

			init = function()
				-- Set up highlight groups
				local base_color = "#404040" -- Default fallback color
				local current_color = "#906060" -- Brighter color for current word

				local hl = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })
				if hl.bg then
					base_color = string.format("#%06x", hl.bg)
					-- Make current highlight 30% brighter
					local r = bit.rshift(bit.band(hl.bg, 0xFF0000), 16)
					local g = bit.rshift(bit.band(hl.bg, 0xFF00), 8)
					local b = bit.band(hl.bg, 0xFF)
					r = math.min(255, r + math.floor(r * 0.3))
					g = math.min(255, g + math.floor(g * 0.3))
					b = math.min(255, b + math.floor(b * 0.3))
					current_color = string.format("#%02x%02x%02x", r, g, b)
				end

				-- Regular word highlights
				vim.api.nvim_set_hl(0, "NeominimapWordLine", { bg = base_color, default = true })
				vim.api.nvim_set_hl(0, "NeominimapWordSign", { fg = base_color, default = true })
				vim.api.nvim_set_hl(0, "NeominimapWordIcon", { fg = base_color, default = true })

				-- Current word highlights
				vim.api.nvim_set_hl(0, "NeominimapCurrentWordLine", { bg = current_color, default = true })
				vim.api.nvim_set_hl(0, "NeominimapCurrentWordSign", { fg = current_color, default = true })
				vim.api.nvim_set_hl(0, "NeominimapCurrentWordIcon", { fg = current_color, default = true })
			end,

			autocmds = {
				{
					event = { "CursorHold", "CursorHoldI" },
					opts = {
						desc = "Update word highlights when cursor moves",
						callback = function(apply)
							local winid = vim.api.nvim_get_current_win()
							if not winid or not vim.api.nvim_win_is_valid(winid) then
								return
							end

							local bufnr = vim.api.nvim_win_get_buf(winid)
							vim.schedule(function()
								if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
									-- Cache current word and its positions
									local word = vim.fn.expand("<cword>")
									if word and word ~= "" then
										local key = bufnr .. word
										if
											not word_highlights[key]
											or word_highlights[key].tick ~= vim.b[bufnr].changedtick
										then
											local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
											local positions = {}
											for lnum, line in ipairs(lines) do
												if line:find(word, 1, true) then
													table.insert(positions, lnum)
												end
											end
											word_highlights[key] = {
												positions = positions,
												tick = vim.b[bufnr].changedtick,
											}
										end
									end
									apply(bufnr)
								end
							end)
						end,
					},
				},
			},

			get_annotations = function(bufnr)
				local word = vim.fn.expand("<cword>")
				if not word or word == "" then
					return {}
				end

				local key = bufnr .. word
				local cached = word_highlights[key]
				if not cached then
					return {}
				end

				-- Get current cursor position
				local current_line = vim.api.nvim_win_get_cursor(0)[1]

				local annotations = {}
				for _, lnum in ipairs(cached.positions) do
					table.insert(annotations, {
						lnum = lnum,
						end_lnum = lnum,
						priority = 25, -- Between search (20) and diagnostics (70-100)
						id = 1,
						highlight = (lnum == current_line) and "NeominimapCurrentWordLine" or "NeominimapWordLine",
					})
				end

				return annotations
			end,
		}

		-- Set up neominimap configuration
		vim.g.neominimap = {
			auto_enable = true,
			handlers = {
				word_handler,
			},
			click = {
				enabled = true,
				auto_switch_focus = true,
			},
		}
	end,
}
