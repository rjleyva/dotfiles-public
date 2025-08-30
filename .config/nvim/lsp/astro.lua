--[[
  Astro LSP configuration (Neovim 0.11.3+)

  This module configures the Astro language server (astro-ls) on a per-project basis.  

  Why per-project?
  Each project may rely on a different version of Astro and TypeScript. By installing
  and running the language server locally, Neovim always communicates with the correct version.
  This prevents version drift between projects, avoids global pollution, and ensures
  reproducibility across machines.

  Manual setup steps (per project):
  - Create a new Astro project:
       `npm create astro@latest`
  - Install project dependencies:
       `npm install`   (or `yarn install` / `bun install`)
  - Add the Astro language server locally:
       `npm install --save-dev @astrojs/language-server`
  - Ensure TypeScript is installed (required by astro-ls):
       `npm install --save-dev typescript`
  - Open Neovim inside the project root. The LSP will:
       - auto-detect the local astro-ls binary in node_modules/.bin
       - locate the TypeScript SDK at node_modules/typescript/lib/
       - attach correctly to the project

  Global install:
  You can install astro-ls globally:
       `npm install -g @astrojs/language-server typescript`
  This will work in Neovim, but it is less reliable because:
    - Different projects may require different versions.
    - Multiple open projects may conflict.
    - Reproducibility is reduced.

  Project root detection:
  We detect the project root dynamically by scanning for markers such as:
    - astro.config.mjs
    - package.json
    - tsconfig.json / jsconfig.json
    - .git
  `.git` is handled as a directory marker, whilst the others are files.  
  This ensures the LSP always attaches to the correct root, even from subdirectories.

  TypeScript SDK requirement:
  Astro LS will fail to initialise unless you provide `typescript.tsdk` under init_options.  
  Setting it under `settings` does not work (Astro ignores it).  
  tsdk must point to the project's local `node_modules/typescript/lib/` folder, which contains
  `tsserverlibrary.js`. Without this, you will see the error:
    "The `typescript.tsdk` init option is required."

  Summary:
  - Install both @astrojs/language-server and typescript as devDependencies.
  - Use project-local astro-ls + TypeScript SDK for correctness and isolation.
  - Global installs are possible, but risky.
  - tsdk must be configured under init_options, not settings.
  - This module is fully modular and integrates directly with the core LSP loader (core/lsp.lua).
--]]

local M = {}

-- Project root markers
local root_markers = {
  'astro.config.mjs',
  'package.json',
  'tsconfig.json',
  'jsconfig.json',
  '.git',
}

-- Find the project root (treat .git as dir, others as files)
local function get_root_dir()
  for _, marker in ipairs(root_markers) do
    local path
    if marker == '.git' then
      path = vim.fn.finddir(marker, vim.fn.getcwd() .. ';')
    else
      path = vim.fn.findfile(marker, vim.fn.getcwd() .. ';')
    end
    if path ~= '' then
      return vim.fn.fnamemodify(path, ':h')
    end
  end
  return vim.fn.getcwd()
end

local root_dir = get_root_dir()

-- Paths for astro language server and typescript sdk
local lsp_path = root_dir .. '/node_modules/.bin/astro-ls'
local tsdk_path =
  vim.fn.fnamemodify(root_dir .. '/node_modules/typescript/lib', ':p')

M.spec = {
  cmd = { 'node', lsp_path, '--stdio' },

  filetypes = { 'astro' },
  root_markers = root_markers,

  -- Astro LS will crash unless `typescript.tsdk` is provided under init_options.
  -- Setting this under `settings` does NOT work (Astro LS ignores it).
  -- tsdk must point to the `node_modules/typescript/lib/` folder containing tsserverlibrary.js.
  init_options = {
    typescript = {
      tsdk = tsdk_path,
    },
  },

  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
}

M.name = 'astro'

return M.spec
