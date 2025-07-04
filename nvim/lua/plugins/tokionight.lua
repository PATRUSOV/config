return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon", -- можно: "storm", "moon", "night", "day"
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      sidebars = { "qf", "help", "terminal", "packer" },
      dim_inactive = true,
      lualine_bold = true,
    },
  },
}
