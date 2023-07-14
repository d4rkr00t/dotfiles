local safe_reqiure = require("ssysoev.utils.safe-require")
local keymap = vim.keymap
local noremap = { noremap = true, silent = true }

-- general keymaps
keymap.set("n", "<esc>", ":noh<cr><esc>", { silent = true, desc = "Remove Search Highlighting" })
keymap.set("n", "x", '"_x') -- in normal mode pressing x doesn't yank the char
keymap.set("n", "Q", "<nop>") -- disable ex mode
keymap.set("n", "q:", "<cmd>q<cr>")
keymap.set("v", "p", '"_dP') -- do not yank if pasting over something
keymap.set("n", "U", "<C-r>") -- redo
keymap.set("n", "<C-s>", "<cmd>normal! m'<cr>") -- add current location to jump list
keymap.set("n", "gl", "$") -- jump to the last char of the line
keymap.set("n", "gh", "^") -- jump to the first char of the line

-- stay in indent mode
keymap.set("v", ">", ">gv")
keymap.set("v", "<", "<gv")

-- <C-D> <C-U> to stay in the middle of the screen
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Search and n N to stay in the middle of the screen
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("c", "<CR>", function()
  return vim.fn.getcmdtype() == "/" and "<CR>zzzv" or "<CR>"
end, { expr = true })

-- move lines visual mode maps
keymap.set("v", "<M-DOWN>", ":m '>+1<CR>gvgv=gv", noremap)
keymap.set("v", "<M-UP>", ":m '<-2<CR>gvgv=gv", noremap)

-- H and L to start/end of line
keymap.set({ "n", "x", "o" }, "H", "^", noremap)
keymap.set({ "n", "x", "o" }, "L", "$", noremap)

-- remap W -> w
vim.api.nvim_create_user_command("W", function()
  vim.cmd("w")
end, { nargs = 0 })

-- remap Q -> q
vim.api.nvim_create_user_command("Q", function()
  vim.cmd("q")
end, { nargs = 0 })

-- close all floating windows
local function close_floating()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

safe_reqiure({ "command_center" }, function(mods)
  local cc = mods.command_center

  cc.add({
    {
      desc = "Open command_center",
      cmd = "<CMD>Telescope command_center<CR>",
      keys = {
        { "n", "<leader>cc", noremap },
        { "v", "<leader>cc", noremap },

        -- If ever hesitate when using telescope start with <leader>f,
        -- also open command center
        { "n", "<leader>f", noremap },
        { "v", "<leader>f", noremap },
      },
    },

    {
      desc = "Open link under cursor",
      cmd = [[:execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]],
      keys = { "n", "gx", noremap },
    },

    {
      desc = "Replace a word under cursor [repetable]",
      cmd = "<cmd>let @/='\\<'.expand('<cword>').'\\>'<cr>\"_ciw",
      keys = { "n", "<leader>cw", noremap },
    },

    {
      desc = "Clear buffers",
      cmd = "<cmd>lua require('close_buffers').delete({type = 'hidden'})<CR>",
    },

    {
      desc = "Close all floating windows",
      cmd = function()
        close_floating()
      end,
    },

    {
      desc = "Toggle hidden characters",
      cmd = "<cmd>set list!<cr>",
      keys = { "n", "<leader>th", noremap },
    },

    -- copy file path
    {
      desc = "Copy Realtive Path",
      cmd = "<cmd>CopyRelPath<cr>",
      keys = { "n", "<leader>cr", noremap },
    },
    {
      desc = "Copy Absolute Path",
      cmd = "<cmd>CopyAbsPath<cr>",
      keys = { "n", "<leader>ca", noremap },
    },

    -- move lines
    {
      desc = "Move lines up",
      cmd = "<cmd>m .-2<cr>==",
      keys = { "n", "<M-UP>", noremap },
    },

    {
      desc = "Move lines up",
      cmd = "<Esc><cmd>m .-2<CR>==gi",
      keys = { "i", "<M-UP>", noremap },
      mode = cc.mode.SET,
    },

    {
      desc = "Move lines down",
      cmd = "<cmd>m .+1<CR>==",
      keys = { "n", "<M-DOWN>", noremap },
    },

    {
      desc = "Move lines down",
      cmd = "<Esc><cmd>m .+1<CR>==gi",
      keys = { "i", "<M-DOWN>", noremap },
      mode = cc.mode.SET,
    },

    -- nvim-window
    {
      desc = "Switch between splits",
      cmd = ":lua require('nvim-window').pick()<CR>",
      keys = { "n", "<leader>w", noremap },
    },

    -- split windows
    {
      desc = "Split window vertically",
      cmd = "<C-w>v",
      keys = { "n", "<leader>sv", noremap },
    },

    {
      desc = "Split window horizontally",
      cmd = "<C-w>s",
      keys = { "n", "<leader>sh", noremap },
    },

    {
      desc = "Make split windows equal size",
      cmd = "<C-w>=",
      keys = { "n", "<leader>se", noremap },
    },

    {
      desc = "Close current split window",
      cmd = ":close<CR>",
      keys = { "n", "<leader>sx", noremap },
    },

    {
      desc = "Reduce the split width",
      cmd = "<cmd>vert resize -2<CR>",
      keys = { "n", "<M-9>", noremap },
    },

    {
      desc = "Increase the split width",
      cmd = "<cmd>vert resize +2<CR>",
      keys = { "n", "<M-0>", noremap },
    },

    {
      desc = "Reduce the split height",
      cmd = "<cmd>resize -2<CR>",
      keys = { "n", "<M-(>", noremap },
    },

    {
      desc = "Increase the split height",
      cmd = "<cmd>resize +2<CR>",
      keys = { "n", "<M-)>", noremap },
    },

    -- nvim tree
    {
      desc = "Toggle NvimTree",
      cmd = ":NvimTreeToggle<CR>",
      keys = { "n", "<leader>ee", noremap },
    },

    {
      desc = "Open NvimTree and focus current file",
      cmd = ":NvimTreeFindFile<CR>",
      keys = { "n", "<leader>ef", noremap },
    },

    -- fzf
    {
      desc = "Fzf find files",
      cmd = "<cmd>lua require('fzf-lua').files(function() return {show_cwd_header=true, cwd=vim.loop.cwd()} end)<CR>",
      keys = { "n", "<leader>ff", noremap },
    },

    {
      desc = "Fzf find all files",
      cmd = "<cmd>lua require('fzf-lua').files(function() return {show_cwd_header=true, cwd=vim.loop.cwd(), cmd = 'fd --type f --exclude .git -I'} end)<CR>",
      keys = { "n", "<leader>fa", noremap },
    },

    {
      desc = "Open recent",
      cmd = "<cmd>Telescope oldfiles cwd_only=true<CR>",
      keys = { "n", "<leader>o", noremap },
    },

    -- {
    --   desc = "Fzf open recent",
    --   cmd = "<cmd>lua require'fzf-lua'.oldfiles({ cwd_only = vim.fn.getcwd(), show_cwd_header=true })<CR>",
    --   keys = { "n", "<leader>o", noremap },
    -- },

    {
      desc = "Fzf git files",
      cmd = "<cmd>FzfLua git_files<CR>",
      keys = { "n", "<leader>fg", noremap },
    },

    {
      desc = "Fzf live grep",
      cmd = "<cmd>FzfLua live_grep_glob<CR>",
      keys = { "n", "<leader>fs", noremap },
    },

    {
      desc = "Fzf document symbols",
      cmd = "<cmd>FzfLua lsp_document_symbols<CR>",
      keys = { "n", "<leader>fo", noremap },
    },

    {
      desc = "Fzf diagnostics",
      cmd = "<cmd>FzfLua diagnostics_document<CR>",
      keys = { "n", "<leader>fd", noremap },
    },

    {
      desc = "Fzf restore previous picker",
      cmd = "<cmd>FzfLua resume<CR>",
      keys = { "n", "<leader>fr", noremap },
    },

    {
      desc = "Fzf search help tags",
      cmd = "<cmd>FzfLua help_tags<CR>",
      keys = { "n", "<leader>fh", noremap },
    },

    {
      desc = "Fzf search commands",
      cmd = "<cmd>FzfLua commands<CR>",
      keys = { "n", "<leader>fc", noremap },
    },

    {
      desc = "Fzf search in current buffer",
      cmd = "<cmd>FzfLua lgrep_curbuf<CR>",
      keys = { "n", "<leader>/", noremap },
    },

    {
      desc = "Fzf buffers",
      cmd = "<cmd>FzfLua buffers<CR>",
      keys = { "n", "<leader>b", noremap },
    },

    {
      desc = "Fzf git status",
      cmd = "<cmd>FzfLua git_status<CR>",
      keys = { "n", "<leader>gs", noremap },
    },

    {
      desc = "Open in Github",
      cmd = '<cmd>lua require"gitlinker".get_buf_range_url("n")<CR>',
      keys = { "n", "<leader>gl", noremap },
    },

    {
      desc = "Open in Github",
      cmd = '<cmd>lua require"gitlinker".get_buf_range_url("v")<CR>',
      keys = { "v", "<leader>gl", noremap },
      mode = cc.mode.SET,
    },

    -- null-ls
    {
      desc = "Format with lsp client",
      cmd = ":lua vim.lsp.buf.format({ async = true })<CR>",
      keys = { "n", "<leader>lf", noremap },
    },

    -- trouble
    {
      desc = "Trouble document diagnostics",
      cmd = "<cmd>Trouble document_diagnostics<CR>",
      keys = { "n", "<leader>xx", noremap },
    },
    {
      desc = "Trouble project diagnostics",
      cmd = "<cmd>Trouble workspace_diagnostics<CR>",
    },

    -- yanky
    {
      desc = "Yanky Cycle Forward",
      cmd = "<Plug>(YankyCycleForward)",
      keys = {
        { "n", "<c-n>", noremap },
        { "x", "<c-n>", noremap },
      },
    },

    {
      desc = "Yanky Cycle Backward",
      cmd = "<Plug>(YankyCycleBackward)",
      keys = {
        { "n", "<c-p>", noremap },
        { "x", "<c-p>", noremap },
      },
    },

    -- commenter
    {
      desc = "Toggle line comment",
      cmd = "<Plug>(comment_toggle_linewise_current)<cr>",
      keys = { "n", "gcc", noremap },
      mode = cc.mode.ADD,
    },

    -- bufferline
    {
      desc = "New tab",
      cmd = "<cmd>tabnew<cr>",
      keys = { "n", "<leader>tt", noremap },
    },

    {
      desc = "Pick tab",
      cmd = "<cmd>BufferLinePick<cr>",
      keys = { "n", "<leader>tp", noremap },
    },

    {
      desc = "Next tab",
      cmd = "<cmd>BufferLineCycleNext<cr>",
      keys = { "n", "<C-l>", noremap },
    },

    {
      desc = "Prev tab",
      cmd = "<cmd>BufferLineCyclePrev<cr>",
      keys = { "n", "<C-h>", noremap },
    },

    -- colorizer
    {
      desc = "Toggle color highlighting",
      cmd = "<cmd>ColorizerToggle<cr>",
      keys = { "n", "<leader>hc", noremap },
    },

    -- gitsigns
    {
      desc = "Gitsigns go to next hunk",
      cmd = "<cmd>Gitsigns next_hunk<cr>",
      keys = { "n", "]h", noremap },
    },

    {
      desc = "Gitsigns go to prev hunk",
      cmd = "<cmd>Gitsigns prev_hunk<cr>",
      keys = { "n", "[h", noremap },
    },
  })
end)
