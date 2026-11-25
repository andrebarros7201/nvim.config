-- nvim-treesitter: parsers for syntax highlighting and indentation
---@module 'lazy'
---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false, -- the main branch does not support lazy-loading
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install {
      'bash',
      'c',
      'cpp',
      'css',
      'diff',
      'html',
      'javascript',
      'json',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'rust',
      'scss',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
    }

    -- Start treesitter for every buffer whose language has an installed parser
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
      callback = function(args)
        local language = vim.treesitter.language.get_lang(args.match)
        if not language or not vim.treesitter.language.add(language) then return end
        vim.treesitter.start(args.buf, language)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
