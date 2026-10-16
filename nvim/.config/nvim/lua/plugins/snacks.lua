return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            exclude = { "node_modules", ".git", "dist", "build", "*.lock" },

            -- 1. Use the 'file' field for sorting (filename)
            -- By removing 'dir' from this list, you stop prioritizing folders.
            sort = { fields = { "file" } },

            -- 2. Ensure the matcher applies sorting to the static tree
            matcher = {
              sort_empty = true, -- Apply sort even when not searching
            },
          },
          files = {
            hidden = true,
            ignored = true,
            exclude = { "node_modules", ".git", "dist", "build", "*.lock" },
          },
        },
      },
    },
  },
}
