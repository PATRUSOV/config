require("lspconfig").ruff.setup({
  init_options = {
    settings = {
      lint = {
        ignore = { "E701", "E702" },
      },
    },
  },
})
