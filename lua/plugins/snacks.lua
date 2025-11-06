return {
  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = true, -- Animated scrolling
      animate = {
        duration = { step = 5, total = 100 },
        easing = "linear",
      },
      -- faster animation when repeating scroll after delay
      animate_repeat = {
        delay = 50, -- delay in ms before using the repeat animation
        duration = { step = 3, total = 20 },
        easing = "linear",
      },
    },
    dim = {
      animate = {
        duration = { step = 5, total = 100 },
        easing = "linear",
      },
    },
    indent = {
      animate = {
        duration = { step = 10, total = 100 },
        easing = "linear",
      },
    },
    animate = {
      duration = 10,
      easing = "linear",
      fps = 60,
    },
  },
}
