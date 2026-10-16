-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>rr", function()
  -- 1. Open the terminal with auto_close disabled
  local term = Snacks.terminal.open("RUST_BACKTRACE=1 cargo run", {
    cwd = LazyVim.root(),
    auto_close = false,
  })

  -- 2. Attach a listener to the "TermClose" event
  term:on("TermClose", function()
    -- vim.v.event.status is the exit code (0 = success)
    if vim.v.event.status == 0 then
      term:close()
    else
      -- Optional: Notify that it failed if you want a heads-up
      vim.notify("Cargo Run failed with exit code " .. vim.v.event.status, vim.log.levels.ERROR)
    end
  end)
end, { desc = "Cargo Run (Success only)" })

-- This opens a terminal toggle; you can type whatever cargo command you want
vim.keymap.set("n", "<leader>rt", function()
  Snacks.terminal.toggle()
end, { desc = "Terminal Toggle" })
