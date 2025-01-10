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
  end,
}
