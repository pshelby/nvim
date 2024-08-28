return {
  "MagicDuck/grug-far.nvim",
  opts = {
    engines = {
      ripgrep = {
        extraArgs = "--hidden -g !.git",
      },
    },
    window = {
      width = 40,
    },
  },
}
