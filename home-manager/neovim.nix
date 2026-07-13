{
  pkgs,
  lib,
  ...
}:

let
  fromGitHub = rev: ref: repo: extraDeps: pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
        rev = rev;
      };
      dependencies = extraDeps;
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      lua-language-server
      nixd
      gopls
      stylua
      ansible-language-server
    ];
    withPython3 = false;
    withRuby = false;

    plugins = let
      nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (treesitter-plugins: 
        with treesitter-plugins; [
          bash
          lua
          nix
	        go
          yaml
        ]);
    in 
      with pkgs.vimPlugins; [
        bufferline-nvim
        neo-tree-nvim
        mini-bufremove
        guess-indent-nvim
        which-key-nvim
        gitsigns-nvim
        nvim-lspconfig
        nvim-treesitter-with-plugins
        blink-cmp
        lush-nvim
	      (fromGitHub "6401334926b7b352594324f4e20f2162f2998a54" "main" "kabouzeid/nvim-jellybeans" [ lush-nvim ] )
        luasnip
        dashboard-nvim
        nvim-web-devicons
      ];
    initLua = ''
      vim.cmd('colorscheme jellybeans')

      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      vim.o.termguicolors = true
      vim.o.number = true
      vim.o.cursorline = true
      vim.o.confirm = true
      vim.o.tabstop = 2
      vim.o.shiftwidth = 2
      vim.o.expandtab = true
      vim.o.showtabline = 2
      vim.o.signcolumn = "yes"

      vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
      vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
      vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
      vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
      vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
      vim.diagnostic.config({
          update_in_insert = false,
          severity_sort = true,
          float = { border = "rounded", source = "if_many" },
          underline = { severity = { min = vim.diagnostic.severity.WARN } },
          virtual_text = true,
          virtual_lines = false,
          jump = { float = true },
      })

      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
				  window = {
            width = 50,
					  mappings = {
						  ["\\"] = "close_window",
					  },
				  },
			  },
      })
      vim.keymap.set("n", "\\", ":Neotree reveal<CR>", { desc = "NeoTree toggle", silent = true })

      require("mini.bufremove").setup()
      vim.keymap.set("n", "<leader>b", function()
        require("mini.bufremove").delete(0, false)
      end, { desc = "Delete buffer" })

      require("bufferline").setup({
          options = {
              node = "buffers",
              diagnostics = "nvim_lsp",
              show_buffer_close_icons = true,
              show_close_icon = true,
              seperator_style = "slant",
              offsets = {
                {
                  filetype = "neo-tree",
                  text = "File Explorer",
                  highlight = "Directory",
                  text_align = "center",
                },
              },
              close_command = function(n)
                require("mini.bufremove").delete(n, false)
              end,
              right_mouse_command = function(n)
                require("mini.bufremove").delete(n, false)
              end,
          },
      })
      vim.opt.showtabline = 2
      vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
      vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

      require("dashboard").setup({
        theme = "hyper",
        config = {
          header = {},
        },
      })

      require("guess-indent").setup({})
      require("gitsigns").setup({
          signs = {
              add          = { text = "+" },
              change       = { text = "~" },
              delete       = { text = "_" },
              topdelete    = { text = "‾" },
              changedelete = { text = "~" },
          },
      })
      vim.keymap.set("n", "]c", ":Gitsigns next_hunk<CR>", { desc = "Next changed chunk" })
      vim.keymap.set("n", "]C", ":Gitsigns prev_hunk<CR>", { desc = "Last changed chunk" })
      require("which-key").setup({
          delay = 0,
          icons = { mappings = vim.g.have_nerd_font },
      })

      require("blink-cmp").setup({
          keymap = { 
            preset = "default",
            ["Tab"] = { "fallback" },
            ["S-Tab"] = { "fallback" },
          },
          appearance = { nerd_font_variant = "mono" },
          completion = {
            documentation = { auto_show = false, auto_show_delay_ms = 500 },
          },
          sources = { default = { "lsp", "path", "snippets" } },
          snippets = { preset = "luasnip" },
          fuzzy = { implementation = "lua" },
          signature = { enabled = true },
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf, filetype = args.buf, args.match
          local language = vim.treesitter.language.get_lang(filetype)
          if not language then return end
          if not vim.treesitter.language.add(language) then return end
          vim.treesitter.start(buf, language)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      vim.lsp.config("lua_ls", {})
      vim.lsp.enable("lua_ls")
      vim.lsp.config("nixd", {})
      vim.lsp.enable("nixd")
      vim.lsp.config("gopls", {})
      vim.lsp.enable("gopls")
      vim.lsp.config("ansiblels", {})
      vim.lsp.enable("ansiblels")
    '';
  };
}
