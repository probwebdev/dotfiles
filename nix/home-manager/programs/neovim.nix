{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    # Match the providers in the previously installed pkgs.neovim package.
    withPython3 = false;
    withRuby = false;
    # Plugins and parsers update together through flake.lock.
    plugins = with pkgs.vimPlugins; [
      nvim-scrollview
      onedarkpro-nvim
      lualine-nvim
      fzf-vim
      zoxide-vim
      autoclose-nvim
      (nvim-treesitter.withPlugins (p:
        with p; [
          astro
          bash
          comment
          css
          dockerfile
          gitignore
          graphql
          html
          javascript
          jsdoc
          json
          json5
          lua
          markdown
          markdown_inline
          regex
          rust
          svelte
          toml
          tsx
          typescript
          vala
          vue
          vim
          vimdoc
          yaml
        ]))
    ];
    extraConfig = ''
      "" Encoding
      set encoding=utf-8
      set fileencoding=utf-8
      set fileencodings=utf-8
      set ttyfast

      "" Fix backspace indent
      set backspace=indent,eol,start

      "" Tabs
      set tabstop=2
      set softtabstop=0
      set shiftwidth=2
      set expandtab

      "" Searching
      set hlsearch
      set incsearch
      set ignorecase
      set smartcase
      set showmatch

      "" Fileformats
      set fileformats=unix,dos,mac

      "" Folding
      "set foldmethod=expr
      "set foldexpr=nvim_treesitter#foldexpr()

      "" Editor
      set ruler
      set number
      set cursorline
      set nocompatible
      set modelines=0
      set noshiftround
      set laststatus=2
      set showmode
      set showcmd
      set cc=80
      set autoindent
      set clipboard=unnamedplus
      set completeopt=menu,menuone,noselect

      colorscheme onedark
      set termguicolors

      lua << END
      require("autoclose").setup()

      require('lualine').setup {
        sections = {
          lualine_x = {
            'encoding',
            {
              'fileformat',
              symbols = {
                unix = 'unix',
                dos = 'dos',
                mac = 'mac',
              }
            },
            'filetype'
          }
        }
      }

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(event)
          local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
          if lang and vim.treesitter.language.add(lang) then
            vim.treesitter.start(event.buf, lang)
            vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
      END
    '';
  };
}
