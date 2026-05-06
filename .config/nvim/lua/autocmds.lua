-- auto remove whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*" },
  command = [[silent execute '! treefmt %']],
})

-- Fix assertion errors for incompatible lsps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method "textDocument/documentColor" then
      vim.lsp.document_color.enable(true, { bufnr = ev.buf })
    end
  end,
})
