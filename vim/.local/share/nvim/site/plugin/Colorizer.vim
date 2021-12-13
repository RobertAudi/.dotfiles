" Plugin: nvim-colorizer.lua
" Description: THE FASTEST NEOVIM COLORIZER
" URL: https://github.com/norcalli/nvim-colorizer.lua

lua <<EOF
  require 'colorizer'.setup {
    'css';
    'javascript';
    'scss';
    'html';
    'haml';
    'erb';
  }
EOF
