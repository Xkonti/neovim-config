return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        disable_inline_completion = true,
        disable_keymaps = true,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "supermaven-inc/supermaven-nvim" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "supermaven" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() then
              if cmp.get_active_entry() then
                cmp.confirm({ select = false })
              else
                fallback()
              end
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = false }),
          c = cmp.mapping.confirm({ select = false }),
        }),
      })

      return opts
    end,
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
  --         if cmp.visible() then
  --           local entry = cmp.get_selected_entry()
  --           if not entry then
  --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
  --           else
  --             cmp.confirm()
  --           end
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s", "c" }),
  --     })
  --   end,
  -- },
}
