" Plugin: securemodelines
" Description: A secure alternative to Vim modelines
" URL: https://github.com/RobertAudi/securemodelines

let g:secure_modelines_allowed_items = [
      \   'textwidth',      'tw',
      \   'softtabstop',    'sts',
      \   'tabstop',        'ts',
      \   'shiftwidth',     'sw',
      \   'expandtab',      'et',   'noexpandtab',   'noet',
      \   'filetype',       'ft',
      \   'foldmarker',     'fmr',
      \   'foldclose',      'fcl',
      \   'foldmethod',     'fdm',
      \   'foldlevel',      'fdl',
      \   'commentstring',  'cms',
      \   'readonly',       'ro',   'noreadonly',    'noro',
      \   'rightleft',      'rl',   'norightleft',   'norl',
      \   'cindent',        'cin',  'nocindent',     'nocin',
      \   'smartindent',    'si',   'nosmartindent', 'nosi',
      \   'autoindent',     'ai',   'noautoindent',  'noai',
      \   'spell',                  'nospell',
      \   'spelllang'
      \ ]
