local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- example plugins:
  {"nvim-lua/plenary.nvim"},
  {"nvim-lualine/lualine.nvim"},
  {"nvim-tree/nvim-web-devicons"},
  {"catppuccin/nvim", name = "catppuccin", priority = 1000  }, 
  {"neovim/nvim-lspconfig" },
--  {"github/copilot.vim"},
})

-- Line numbers
vim.opt.number = true

-- Spaces instead of tabs
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Relative line numbers
vim.opt.relativenumber = true

-- Case‑insensitive search, smart case
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.foldlevel = 99
vim.keymap.set("n", " ", "za", { noremap = true, silent = true })

vim.keymap.set("n", "gn", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gp", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gd", ":bdelete<CR>", { noremap = true, silent = true })

vim.keymap.set("n", ",d", "oimport ipdb; ipdb.set_trace()<Esc>:w<CR>", { noremap = true, silent = true })

vim.cmd.colorscheme "catppuccin-mocha"

-- copilot

-- vim.g.copilot_workspace_folders={"~/work-berlin", "~/programs/scripties", "~/programs/periodic_trends"}

-- lsp + completion

local map = vim.keymap.set

-- Completion capabilities for LSP
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- Basic on_attach for keymaps
local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  map("n", "gd", vim.lsp.buf.definition)
  map("n", "K",  vim.lsp.buf.hover)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "<leader>rn", vim.lsp.buf.rename)
end


