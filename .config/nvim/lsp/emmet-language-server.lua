local M = {}

M.spec = {
  cmd = {
    'emmet-language-server',
    '--stdio',
  },

  filetypes = {
    'html',
    'css',
    'scss',
    'javascriptreact',
    'typescriptreact',
    'svelte',
    'astro',
  },

  init_options = {
    includeLanguages = {
      javascript = 'javascriptreact',
      typescript = 'typescriptreact',
    },
    showExpandedAbbreviation = 'always', -- Always show live preview of expansions
    showAbbreviationSuggestions = true, -- Suggest possible abbreviations
    syntaxProfiles = {
      html = {
        selfClosingStyle = 'xhtml', -- <img /> instead of <img>
      },
    },
    options = {
      -- BEM methodology support
      ['bem.enabled'] = true,

      -- Output formatting
      ['output.selfClosingTag'] = true, -- Always close void tags
      ['output.indent'] = '  ', -- Use 2 spaces
      ['output.newline'] = '\n', -- Enforce LF
    },
  },

  single_file_support = true,
}

M.name = 'emmet_ls'

return M.spec
