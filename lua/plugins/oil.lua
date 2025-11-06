return {
  "stevearc/oil.nvim",
  keys = {
    {
      "<leader>o",
      function()
        require("oil").set_columns({ "icon", "size", "mtime" })
        vim.cmd("Oil")
      end,
      desc = "Oil simple",
    },
    {
      "<leader>O",
      function()
        require("oil").set_columns({ "icon", "size", "ctime", "mtime", "permissions" })
        vim.cmd("Oil")
      end,
      desc = "Oil with permissions",
    },
  },
  opts = {
    columns = {
      "icon",
      -- "permissions",
      "size",
      "mtime",
    },
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["q"] = { "actions.close", mode = "n", desc = "Close Oil" },
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
