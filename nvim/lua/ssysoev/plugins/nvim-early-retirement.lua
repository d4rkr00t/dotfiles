return {
  -- close unused buffers
  {
    "chrisgrieser/nvim-early-retirement",
    opts = {
      retirementAgeMins = 30,
    },
    event = "VeryLazy",
  },
}
