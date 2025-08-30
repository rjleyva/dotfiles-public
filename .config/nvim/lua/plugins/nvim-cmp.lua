local M = {}

M.spec = {
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter' },

  dependencies = {

    -- Core completion sources
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },

    -- Snippets engine
    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp',
      dependencies = { 'rafamadriz/friendly-snippets' },
      opts = {
        history = true,
        updateevents = 'TextChanged,TextChangedI',
        enable_autosnippets = true,
      },
      config = function(_, opts)
        local luasnip = require 'luasnip'
        luasnip.config.set_config(opts)

        -- Load only the snippets relevant to LSP
        require('luasnip.loaders.from_vscode').lazy_load {
          include = {
            'astro',
            'css',
            'html',
            'javascript',
            'typescript',
            'json',
            'yaml',
            'graphql',
            'lua',
            'markdown',
            'python',
            'go',
          },
        }

        -- Optional: load project-local snippets from ./snippets
        require('luasnip.loaders.from_vscode').lazy_load {
          paths = { './snippets' },
        }
      end,
    },
  },

  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    -- Global cmp setup
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },

      sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          local source_names = {
            nvim_lsp = '[LSP]',
            luasnip = '[Snip]',
            buffer = '[Buf]',
            path = '[Path]',
            ['vim-dadbod-completion'] = '[DB]',
          }
          vim_item.menu = source_names[entry.source.name]
            or ('[' .. entry.source.name .. ']')
          return vim_item
        end,
      },
    }

    -- SQL-specific setup: enable vim-dadbod-completion only in SQL buffers
    cmp.setup.filetype({ 'sql', 'mysql', 'plsql' }, {
      sources = cmp.config.sources {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
      },
    })
  end,
}

return M.spec
