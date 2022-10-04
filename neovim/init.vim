call plug#begin()

Plug 'wfxr/minimap.vim'
Plug 'olimorris/onedarkpro.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

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
filetype plugin indent on
set clipboard=unnamedplus
set completeopt=menu,menuone,noselect

syntax enable
colorscheme onedarkpro

lua << END
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
END

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "astro",
    "bash",
    "comment",
    "css",
    "dockerfile",
    "gitignore",
    "graphql",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "lua",
    "markdown",
    "regex",
    "rust",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "vala",
    "vue",
    "vim",
    "yaml"
  },
  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- list of language that will be disabled
    disable = { "" },
    additional_vim_regex_highlighting = false,
  },

  indent = {
    -- dont enable this, messes up python indentation
    enable = true,
    disable = {},
  },
}
EOF