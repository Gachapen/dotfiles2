return {
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            inlayHints = {
              parameterHints = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
}
