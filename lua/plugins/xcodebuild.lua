-- Add only on MacOS
return {
  "wojciech-kulik/xcodebuild.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim", -- Fuzzy finder for pickers
    "MunifTanjim/nui.nvim", -- UI components
    "nvim-treesitter/nvim-treesitter", -- Syntax parsing
  },
  config = function()
    require("xcodebuild").setup({
      -- Automatically restore last selected scheme/device
      restore_on_start = true,

      -- Show code coverage after running tests
      code_coverage = {
        enabled = true,
      },

      -- Optional: Configure log formatter
      logs = {
        -- Use xcbeautify if installed, otherwise use built-in parser
        logs_formatter = "xcbeautify --disable-colored-output",
      },
    })

    -- ============================================
    -- Key Mappings (customize prefix if needed)
    -- ============================================

    -- Main picker - shows all available actions
    vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show Xcodebuild Actions" })

    -- Project management - add files, update targets, etc.
    vim.keymap.set("n", "<leader>xaf", "<cmd>XcodebuildProjectManager<cr>", { desc = "Show Project Manager Actions" })

    -- ============================================
    -- Building & Running
    -- ============================================

    vim.keymap.set("n", "<leader>xab", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })

    vim.keymap.set("n", "<leader>xar", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run Project" })

    -- Clean build folder (like Cmd+Shift+K in Xcode)
    vim.keymap.set("n", "<leader>xak", "<cmd>XcodebuildClean<cr>", { desc = "Clean Build Folder" })

    -- ============================================
    -- Testing
    -- ============================================

    -- Run all tests in current scheme
    vim.keymap.set("n", "<leader>xat", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })

    -- Run all tests in current file
    vim.keymap.set("n", "<leader>xaT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run This Test Class" })

    -- Run specific test under cursor or selected tests (visual mode)
    vim.keymap.set("v", "<leader>xaT", "<cmd>XcodebuildTestSelected<cr>", { desc = "Run Selected Tests" })

    -- Repeat last test run
    vim.keymap.set("n", "<leader>xaR", "<cmd>XcodebuildTestRepeat<cr>", { desc = "Repeat Last Test" })

    -- ============================================
    -- Configuration
    -- ============================================

    -- Select device (simulator orphysical device)
    vim.keymap.set("n", "<leader>xad", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })

    -- Select scheme (different build configurations)
    vim.keymap.set("n", "<leader>xax", "<cmd>XcodebuildSelectScheme<cr>", { desc = "Select Scheme" })

    -- Select test plan (if you have multiple test plans)
    vim.keymap.set("n", "<leader>xap", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })

    -- ============================================
    -- Logs & Debugging
    -- ============================================

    -- Toggle build/test logs window
    vim.keymap.set("n", "<leader>xal", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Xcodebuild Logs" })

    -- Show QuickFix list (errors, warnings, test failures)
    vim.keymap.set("n", "<leader>xaq", "<cmd>Telescope quickfix<cr>", { desc = "Show QuickFix List" })

    -- ============================================
    -- Code Coverage
    -- ============================================

    vim.keymap.set("n", "<leader>xac", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Code Coverage" })

    vim.keymap.set(
      "n",
      "<leader>xaC",
      "<cmd>XcodebuildShowCodeCoverageReport<cr>",
      { desc = "Show Code Coverage Report" }
    )

    -- ============================================
    -- Snapshot Testing (if using snapshot tests)
    -- ============================================

    vim.keymap.set("n", "<leader>xas", "<cmd>XcodebuildFailingSnapshots<cr>", { desc = "Show Failing Snapshots" })
  end,
}
