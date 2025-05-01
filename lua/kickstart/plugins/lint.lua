return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        javascriptreact = { 'eslint' },
        typescriptreact = { 'eslint' },
      }

      lint.linters = {
        eslint = {
          name = 'eslint',
          cmd = 'eslint',
          stdin = true,
          args = {
            '--format',
            'json',
            '--stdin',
            '--stdin-filename',
            function()
              return vim.api.nvim_buf_get_name(0)
            end,
          },
          stream = 'stdout',
          ignore_exitcode = true, -- <--- prevents errors from stopping lint
          parser = function(output, bufnr)
            local ok, decoded = pcall(vim.json.decode, output)
            if not ok or not decoded or not decoded[1] then
              return {}
            end

            local diagnostics = {}
            for _, d in ipairs(decoded[1].messages or {}) do
              table.insert(diagnostics, {
                bufnr = bufnr,
                lnum = d.line - 1,
                end_lnum = (d.endLine or d.line) - 1,
                col = d.column - 1,
                end_col = (d.endColumn or d.column) - 1,
                severity = d.severity == 2 and 1 or 2, -- 1 = ERROR, 2 = WARN
                message = ('%s [%s]'):format(d.message, d.ruleId or 'eslint'),
                source = 'eslint',
              })
            end
            return diagnostics
          end,
        },
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
