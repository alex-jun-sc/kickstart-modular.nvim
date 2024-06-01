return {
  {
    -- a buffer manager that provides an easy interface for a couple things:
    -- * managing open files without mental overhead
    -- * bn, bp
    -- * storing open buffer list to a file (haven't found this useful yet)
    --
    -- 5.31 - after working on a monorepo we are going back to
    -- harpoon LOL
    -- persisting harpoons is very desirable.
    --
    -- This has now become my full harpoon interface
    -- - teleport to harpooned location
    -- manage buffer list (add, delete, reorder)
    -- In the future, use this to help compose argument list
    --
    -- Also note - the number by each line indicates nesting
    'j-morano/buffer_manager.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local opts = { noremap = true }
      local map = vim.keymap.set
      -- Setup
      require('buffer_manager').setup {
        select_menu_item_commands = {
          v = {
            key = '<C-v>',
            command = 'vsplit',
          },
          h = {
            key = '<C-h>',
            command = 'split',
          },
        },
        focus_alternate_buffer = false,
        short_file_names = false,
        short_term_names = false,
        loop_nav = false,
        highlight = 'Normal:BufferManagerBorder',
        win_extra_options = {
          winhighlight = 'Normal:BufferManagerNormal',
        },
      }

      -- Do not use - this messes with some stuff like
      -- deleting multiple lines
      -- Navigate buffers bypassing the menu
      local bmui = require 'buffer_manager.ui'
      -- local keys = '1234567890'
      -- for i = 1, #keys do
      --   local key = keys:sub(i, i)
      --   map('n', string.format('<M-%s>', key), function()
      --     bmui.nav_file(i)
      --   end, opts)
      -- end

      -- Open menu and search
      -- map({ 't', 'n' }, '<M-c>', function()
      --   bmui.toggle_quick_menu()
      --   -- wait for the menu to open
      --   vim.defer_fn(function()
      --     vim.fn.feedkeys '/'
      --   end, 50)
      -- end, opts)
      -- Next/Prev

      -- ===========================
      --     harpoon functions
      -- ===========================
      -- Give homerow harpoon access
      -- Toggle the menu
      -- Switch between adjacent ones
      map({ 't', 'n' }, '<M-b>', bmui.toggle_quick_menu, opts)
      -- map({ 't', 'n' }, '<M-m>', bmui.toggle_quick_menu, opts)
      -- map('n', '<M-j>', function()
      --   bmui.nav_file(1)
      -- end, opts)
      -- map('n', '<M-k>', function()
      --   bmui.nav_file(2)
      -- end, opts)
      -- map('n', '<M-l>', function()
      --   bmui.nav_file(3)
      -- end, opts)
      -- map('n', '<M-;>', function()
      --   bmui.nav_file(4)
      -- end, opts)
      -- map('n', '<M-n>', bmui.nav_next, opts)
      -- map('n', '<M-p>', bmui.nav_prev, opts)

      -- ===========================
      --   alternate harpoons
      -- ===========================
      -- for usage on mac, because meta is finnicky
      -- backslash becomes new "harpoon key"
      map({ 't', 'n' }, 'zb', bmui.toggle_quick_menu, opts)
      -- map({ 't', 'n' }, '\\m', bmui.toggle_quick_menu, opts)
      -- map('n', '\\j', function()
      --   bmui.nav_file(1)
      -- end, opts)
      -- map('n', '\\k', function()
      --   bmui.nav_file(2)
      -- end, opts)
      -- map('n', '\\l', function()
      --   bmui.nav_file(3)
      -- end, opts)
      -- map('n', '\\;', function()
      --   bmui.nav_file(4)
      -- end, opts)
      -- map('n', '\\n', bmui.nav_next, opts)
      -- map('n', '\\p', bmui.nav_prev, opts)
    end,
  },
}
