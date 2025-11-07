-- https://github.com/jake-stewart/multicursor.nvim
return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      -- TODO: Evaluate if these are even useful - c-q might be good enough
      set({ "n", "x" }, "<s-up>", function()
        mc.lineAddCursor(-1)
      end)
      set({ "n", "x" }, "<s-down>", function()
        mc.lineAddCursor(1)
      end)
      set({ "n", "x" }, "<c-s-up>", function()
        mc.lineSkipCursor(-1)
      end)
      set({ "n", "x" }, "<c-s-down>", function()
        mc.lineSkipCursor(1)
      end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "x" }, "<leader>an", function()
        mc.matchAddCursor(1)
      end)
      set({ "n", "x" }, "<leader>as", function()
        mc.matchSkipCursor(1)
      end)
      set({ "n", "x" }, "<leader>aN", function()
        mc.matchAddCursor(-1)
      end)
      set({ "n", "x" }, "<leader>aS", function()
        mc.matchSkipCursor(-1)
      end)

      -- Add and remove cursors with control + left click.
      set("n", "<c-leftmouse>", mc.handleMouse)
      set("n", "<c-leftdrag>", mc.handleMouseDrag)
      set("n", "<c-leftrelease>", mc.handleMouseRelease)

      -- Disable and enable cursors.
      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you h    ave overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- ADVANCED ACTIONS

      -- Pressing `gaip` will add a cursor on each line of a paragraph.
      set("n", "<leader>aga", mc.addCursorOperator)

      -- Clone every cursor and disable the originals.
      set({ "n", "x" }, "<leader><c-q>", mc.duplicateCursors)

      -- Align cursor columns.
      set("n", "<leader>aa", mc.alignCursors)

      -- bring back cursors if you accidentally clear them
      set("n", "<leader>agv", mc.restoreCursors)

      -- Add a cursor for all matches of cursor word/selection in the document.
      set({ "n", "x" }, "<leader>aA", mc.matchAllAddCursors)

      -- Rotate the text contained in each visual selection between cursors.
      set("x", "<leader>at", function()
        mc.transposeCursors(1)
      end)
      set("x", "<leader>aT", function()
        mc.transposeCursors(-1)
      end)

      -- Append/insert for each line of visual selections.
      -- Similar to block selection insertion.
      set("x", "<leader>aI", mc.insertVisual)
      set("x", "<leader>aA", mc.appendVisual)

      -- Increment/decrement sequences, treaing all cursors as one sequence.
      set({ "n", "x" }, "g<c-a>", mc.sequenceIncrement)
      set({ "n", "x" }, "g<c-x>", mc.sequenceDecrement)

      -- Add a cursor and jump to the next/previous search result.
      set("n", "<leader>a/n", function()
        mc.searchAddCursor(1)
      end)
      set("n", "<leader>a/N", function()
        mc.searchAddCursor(-1)
      end)

      -- Jump to the next/previous search result without adding a cursor.
      set("n", "<leader>a/s", function()
        mc.searchSkipCursor(1)
      end)
      set("n", "<leader>a/S", function()
        mc.searchSkipCursor(-1)
      end)

      -- Add a cursor to every search result in the buffer.
      set("n", "<leader>a/A", mc.searchAllAddCursors)

      -- Pressing `<leader>miwap` will create a cursor in every match of the
      -- string captured by `iw` inside range `ap`.
      -- This action is highly customizable, see `:h multicursor-operator`.
      set({ "n", "x" }, "<leader>am", mc.operator)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
}
