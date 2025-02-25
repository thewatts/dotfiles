-- The goal of nvim-ufo is to make Neovim's fold look modern and keep high performance.
return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" }, -- Include the async library

  config = function()
    -- Set Vim options for folding
    vim.o.foldcolumn = '1' -- Display fold column
    vim.o.foldlevel = 99   -- Set fold level
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Key mappings for opening and closing all folds
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    vim.api.nvim_set_keymap('n', '<C-]>', 'za', { noremap = true, silent = true }) -- Fold under cursor

    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (' 󰁂 %d '):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, 'MoreMsg' })
      return newVirtText
    end

    -- Initialize ufo with default settings
    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
      fold_virt_text_handler = handler
    })

    -- 🏆 **Zed-style keybindings with Option-Control-K (`<A-C-k>`)** 🏆
    local ufo = require('ufo')

    -- Basic Fold/Unfold (Zed: `alt-cmd-[` / `alt-cmd-]`)
    vim.keymap.set('n', '<A-C-[>', ufo.closeFoldsWith, { noremap = true, silent = true })       -- Close fold at cursor
    vim.keymap.set('n', '<A-C-]>', ufo.openFoldsExceptKinds, { noremap = true, silent = true }) -- Open fold at cursor

    -- Toggle Fold (Zed: `cmd-k cmd-l` → now `opt-ctrl-k l`)
    vim.keymap.set('n', '<A-C-k><A-C-l>', 'za', { noremap = true, silent = true }) -- Toggle fold under cursor

    -- Recursive Fold/Unfold (Zed: `cmd-k cmd-[` → `opt-ctrl-k [`  and `cmd-k cmd-]` → `opt-ctrl-k ]`)
    vim.keymap.set('n', '<A-C-k><A-C-[>', ufo.closeAllFolds, { noremap = true, silent = true }) -- Fold recursively
    vim.keymap.set('n', '<A-C-k><A-C-]>', ufo.openAllFolds, { noremap = true, silent = true })  -- Unfold recursively

    -- Fold at Level (Zed: `cmd-k cmd-<number>` → `opt-ctrl-k <number>`)
    for i = 1, 9 do
      vim.keymap.set('n', '<A-C-k><A-C-' .. i .. '>', function() ufo.closeFoldsWith(i) end,
        { noremap = true, silent = true })
    end

    -- Fold Everything (Zed: `cmd-k cmd-0` → `opt-ctrl-k 0`)
    vim.keymap.set('n', '<A-C-k><A-C-0>', ufo.closeAllFolds, { noremap = true, silent = true })

    -- Unfold Everything (Zed: `cmd-k cmd-j` → `opt-ctrl-k j`)
    vim.keymap.set('n', '<A-C-k><A-C-j>', ufo.openAllFolds, { noremap = true, silent = true })
  end,
}
