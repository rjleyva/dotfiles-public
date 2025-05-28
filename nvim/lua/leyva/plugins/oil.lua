return {
  "stevearc/oil.nvim",
  version = "*",
  lazy = false,
  dependencies = { "echasnovski/mini.icons" },

  opts = {
    default_file_explorer = true,
    columns = { "icon" },
    use_default_keymaps = true,
    delete_to_trash = false,
    cleanup_delay_ms = 2000,

    lsp_file_methods = {
      enabled = true,
      timeout_ms = 1000,
      autosave_changes = false,
    },

    constrain_cursor = "editable",
    watch_for_changes = true,

    win_options = {
      winbar = "%{v:lua.CustomOilBar()}",
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },

    keymaps = {
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true } },
      ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
      ["<C-t>"] = { "actions.select", opts = { tab = true } },
      ["<C-p>"] = "actions.preview",
      ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" } },
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
      ["g?"] = "actions.show_help",
    },

    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, _)
        return name:sub(1, 1) == "."
      end,
      is_always_hidden = function(name, _)
        local folder_skip = { "dev-tools.locks", "dune.lock", "_build" }
        return vim.tbl_contains(folder_skip, name)
      end,
      natural_order = "fast",
      case_insensitive = true,
      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },
    },

    git = {
      add = function(_)
        return false
      end,
      mv = function(_, _)
        return false
      end,
      rm = function(_)
        return false
      end,
    },

    float = {
      padding = 2,
      max_width = 0.8,
      max_height = 0.8,
      border = "rounded",
      win_options = {
        winblend = 10,
      },
      preview_split = "right",
      override = function(conf)
        return conf
      end,
    },

    preview_win = {
      update_on_cursor_moved = true,
      preview_method = "fast_scratch",
      disable_preview = function(_)
        return false
      end,
      win_options = {},
    },

    confirmation = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = 0.9,
      min_height = { 5, 0.1 },
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },

    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      border = "rounded",
      minimized_border = "none",
      win_options = {
        winblend = 0,
      },
    },

    ssh = {
      border = "rounded",
    },

    keymaps_help = {
      border = "rounded",
    },
  },

  config = function(_, opts)
    CustomOilBar = function()
      local path = vim.fn.expand("%")
      path = path:gsub("oil://", "")
      return "  " .. vim.fn.fnamemodify(path, ":.")
    end

    require("mini.icons").setup()
    require("oil").setup(opts)

    vim.api.nvim_set_hl(0, "WinBar", { fg = "#d3869b", bg = "#282828", bold = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "WinBar", { fg = "#d3869b", bg = "#282828", bold = true })
      end,
    })

    vim.keymap.set("n", "^", function()
      require("oil").open()
    end, { desc = "Open parent directory" })

    vim.keymap.set("n", "<leader>^", function()
      require("oil").toggle_float()
    end, { desc = "Toggle floating Oil" })
  end,
}
