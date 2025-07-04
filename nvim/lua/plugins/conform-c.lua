return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      ["clang-format"] = {
        prepend_args = {
          "--style={BasedOnStyle: Google, IndentWidth: 4, UseTab: Never}",
        },
      },
    },
  },
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
  },
}
