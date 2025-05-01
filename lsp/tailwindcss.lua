vim.lsp.config('tailwindcss', {
  filetypes = {
    'html',
    'css',
    'scss',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'svelte',
    'vue',
    'templ', -- add/remove as needed
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          -- For Tailwind class extraction from libraries like clsx, twMerge, cva
          'clsx\\(([^)]*)\\)',
          'cva\\(([^)]*)\\)',
          'twMerge\\(([^)]*)\\)',
        },
      },
    },
  },
})
