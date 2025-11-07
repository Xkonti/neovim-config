return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local icons = LazyVim.config.icons

    local opts = {
      options = {
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
        section_separators = "", -- Remove section separators to save space
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              local mode_map = {
                ["NORMAL"] = "N",
                ["INSERT"] = "I",
                ["VISUAL"] = "V",
                ["V-LINE"] = "VL",
                ["V-BLOCK"] = "VB",
                ["COMMAND"] = "C",
                ["REPLACE"] = "R",
                ["TERMINAL"] = "T",
                ["SELECT"] = "S",
                ["S-LINE"] = "SL",
                ["S-BLOCK"] = "SB",
                ["EX"] = "X",
              }
              return mode_map[str] or str:sub(1, 1) -- Fallback to first character
            end,
          },
        },
        lualine_b = {}, -- Removed 'branch' to free up space

        lualine_c = {
          LazyVim.lualine.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path({ length = 5 }) }, -- Show full path without truncation
        },
        lualine_x = {
          Snacks.profiler.status(),
          -- stylua: ignore
          -- Note: LSP warnings about noice.api.status.command.get/has are false positives - these methods exist at runtime
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return { fg = Snacks.util.color("Statement") } end,
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,
          },
        },
        lualine_y = {
          { "progress", separator = "", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {}, -- Removed time display to free up space
      },
      extensions = { "neo-tree", "lazy", "fzf" },
    }

    -- Add trouble symbols if available
    if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
      table.insert(opts.sections.lualine_c, {
        symbols and symbols.get,
        cond = function()
          return vim.b.trouble_lualine ~= false and symbols.has()
        end,
      })
    end

    return opts
  end,
}
