return {
  "ibhagwan/fzf-lua",
  enabled = true,
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
  },
  keys = {
    {
      "<leader>fc",
      function()
        require("fzf-lua").commands()
      end,
      desc = "Search commands",
    },
    {
      "<leader>fC",
      function()
        require("fzf-lua").command_history()
      end,
      desc = "Search command history",
    },
    {
      "<leader>ff",
      function()
        require("fzf-lua").files()
      end,
      desc = "Search files",
    },
    {
      "<leader>fh",
      function()
        require("fzf-lua").highlights()
      end,
      desc = "Search highlights",
    },
    {
      "<leader>fm",
      function()
        require("fzf-lua").marks()
      end,
      desc = "Search marks",
    },
    {
      "<leader>fk",
      function()
        require("fzf-lua").keymaps()
      end,
      desc = "Search keymaps",
    },
    {
      "<leader>fl",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "Live grep",
    },
    {
      "<leader>fgf",
      function()
        require("fzf-lua").git_files()
      end,
      desc = "Search git files",
    },
    {
      "<leader>fgb",
      function()
        require("fzf-lua").git_branches()
      end,
      desc = "Search git branches",
    },
    {
      "<leader>fgc",
      function()
        require("fzf-lua").git_commits()
      end,
      desc = "Search git commits",
    },
    {
      "<leader>fgC",
      function()
        require("fzf-lua").git_bcommits()
      end,
      desc = "Search buffer git commits",
    },
    {
      "<leader>fr",
      function()
        require("fzf-lua").resume()
      end,
      desc = "Resume previous search",
    },
    {
      "<leader>fb",
      function()
        require("fzf-lua").dap_breakpoints()
      end,
      desc = "FZF: DAP Breakpoints",
    },
    {
      "<leader>fv",
      function()
        require("fzf-lua").dap_variables()
      end,
      desc = "FZF: DAP Variables",
    },
    {
      "<leader>fs",
      function()
        require("fzf-lua").dap_frames()
      end,
      desc = "FZF: DAP Stack Frames",
    },
    {
      "<leader>fd",
      function()
        vim.cmd("FzfDirectories")
      end,
      desc = "Search directories",
    },
    {
      "<leader>fR",
      function()
        require("fzf-lua").lsp_references()
      end,
      desc = "References",
    },
    {
      "<leader>fD",
      function()
        require("fzf-lua").lsp_definitions()
      end,
      desc = "Definitions",
    },
    {
      "<leader>fi",
      function()
        require("fzf-lua").lsp_implementations()
      end,
      desc = "Implementations",
    },
    {
      "<leader>ft",
      function()
        require("fzf-lua").lsp_typedefs()
      end,
      desc = "Type Definitions",
    },
  },
  opts = {
    file_icon_padding = "",
    keymap = {
      fzf = {
        ["CTRL-Q"] = "select-all+accept",
      },
    },
    fzf_opts = {
      ["--wrap"] = true,
    },
    winopts = {
      preview = {
        wrap = "wrap",
      },
      formatter = "path.filename_first",
    },
  },
  config = function(_, opts)
    local fzf = require("fzf-lua")
    fzf.setup(opts)

    fzf.dap = require("fzf-lua.providers.dap")

    vim.api.nvim_create_user_command("FzfDirectories", function()
      local cwd = vim.fn.getcwd()
      fzf.fzf_exec("fd --type d", {
        prompt = require("fzf-lua.path").shorten(cwd) .. "> ",
        cwd = cwd,
        actions = {
          ["default"] = function(selected)
            vim.cmd("Oil --float " .. vim.fn.fnameescape(cwd .. "/" .. selected[1]))
          end,
        },
      })
    end, {})

    vim.api.nvim_create_user_command("FzfGitFiles", function()
      fzf.fzf_exec("git ls-files", { prompt = "Git Files > " })
    end, {})
  end,
}
