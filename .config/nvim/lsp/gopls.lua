--[[
  gopls LSP configuration (Neovim 0.11.3+)

  Setup process:
  - Install Go via Homebrew:
       `brew install go`
     - This installs the Go compiler, runtime, and standard tools on macOS.

  - Install gopls via Go:
       `go install golang.org/x/tools/gopls@latest`
     - Installs gopls into $GOPATH/bin (usually ~/.go/bin)
     - Ensures gopls version matches your Go version for full feature support.

  - Configure Neovim LSP:
     - cmd points to the Go-installed gopls:
         `vim.fn.expand('~/.go/bin/gopls')`
     - All other settings (codelenses, hints, analyses, experimental flags) are
       optimized for multi-module projects and large codebases.

  - Summary:
     - memoryMode = 'DegradeClosed' helps performance for large projects.
     - `experimentalPostfixCompletions` and `experimentalWorkspaceModule` enhance editor
       experience with multi-module workspaces.
--]]

local M = {}

M.spec = {
  cmd = {
    vim.fn.expand '~/go/bin/gopls',
  },

  filetypes = {
    'go',
    'gomod',
    'gowork',
    'gotmpl',
    'gosum',
  },

  root_markers = {
    'go.mod',
    'go.work',
    '.git',
  },

  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      semanticTokens = true,
      usePlaceholders = true,
      completeUnimported = true,
      memoryMode = 'DegradeClosed', -- reduces memory usage
      experimentalPostfixCompletions = true,
      experimentalWorkspaceModule = true,

      codelenses = {
        gc_details = true,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },

      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },

      analyses = {
        appends = true,
        asmdecl = true,
        assign = true,
        atomic = true,
        atomicalign = true,
        bools = true,
        buildtag = true,
        cgocall = true,
        composites = true,
        copylocks = true,
        deepequalerrors = true,
        defers = true,
        deprecated = true,
        directive = true,
        embed = true,
        errorsas = true,
        fillreturns = true,
        framepointer = true,
        gofix = true,
        hostport = true,
        infertypeargs = true,
        lostcancel = true,
        httpresponse = true,
        ifaceassert = true,
        loopclosure = true,
        nilfunc = true,
        nilness = true,
        nonewvars = true,
        noresultvalues = true,
        printf = true,
        shadow = true,
        shift = true,
        sigchanyzer = true,
        simplifycompositelit = true,
        simplifyrange = true,
        simplifyslice = true,
        slog = true,
        sortslice = true,
        stdmethods = true,
        stdversion = true,
        stringintconv = true,
        structtag = true,
        testinggoroutine = true,
        tests = true,
        timeformat = true,
        unmarshal = true,
        unsafeptr = true,
        unusedparams = true,
        unusedwrite = true,
        unusedfunc = true,
        unusedresult = true,
        useany = true,
        unreachable = true,
        waitgroup = true,
        yield = true,
      },

      directoryFilters = {
        '-.git',
        '-.vscode',
        '-.idea',
        '-.vscode-test',
        '-node_modules',
      },
    },
  },
}

M.name = 'gopls'

return M.spec
