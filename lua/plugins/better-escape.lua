return {
  "max397574/better-escape.nvim",
  event = "InsertEnter", -- Load only when entering insert mode
  opts = {
    mapping = { "jj", "jk" }, -- key sequences to escape
    timeout = 200, -- time in ms to wait for sequence completion
    clear_empty_lines = false,
  },
}
