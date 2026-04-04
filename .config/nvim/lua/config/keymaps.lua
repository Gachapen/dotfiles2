-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keymap to run 'cargo run' using Snacks.terminal
vim.keymap.set("n", "<leader>rr", function()
  Snacks.terminal.open("cargo run", { cwd = LazyVim.root() })
end, { desc = "Cargo Run (Snacks)" })

-- This opens a terminal toggle; you can type whatever cargo command you want
vim.keymap.set("n", "<leader>rt", function()
  Snacks.terminal.toggle()
end, { desc = "Terminal Toggle" })
