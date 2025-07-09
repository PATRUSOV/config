return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          init_options = {
            settings = {
              lint = {
                ignore = { "E701", "E702" },
              },
            },
          },
        },
      },
    },
  },
}
