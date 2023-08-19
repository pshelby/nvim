return {
  "nvim-neotest/neotest",
  optional = true,
  dependencies = {
    "nvim-neotest/neotest-python",
    "rouge8/neotest-rust",
  },
  opts = {
    adapters = {
      ["neotest-python"] = {},
      ["neotest-rust"] = {},
    },
  },
}
