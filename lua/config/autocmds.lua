-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable the autocmd group first
vim.api.nvim_clear_autocmds({ group = "lazyvim_close_with_q" })

-- Recreate without "help"
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Create modified for help-only
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_help_with_q", { clear = true }),
  pattern = {
    "help",
  },
  callback = function(event)
    if vim.bo[event.buf].buftype == "help" then
      vim.keymap.set("n", "q", "<cmd>close<cr>", {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end
  end,
})
