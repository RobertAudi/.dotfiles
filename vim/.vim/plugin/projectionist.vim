" Prefere *_spec.rb rather than *_test.rb with :A
let g:rails_projections = {
      \   'app/*.rb': {
      \     'alternate': 'spec/{}_spec.rb'
      \   },
      \   'spec/*_spec.rb': {
      \     'alternate': 'app/{}.rb'
      \   },
      \   'config/routes.rb': {
      \     'command': 'routes'
      \   },
      \   'spec/factories/*.rb': {
      \     'command': 'factories'
      \   },
      \   'spec/factories.rb': {
      \     'command': 'factories'
      \   },
      \   'app/services/*.rb': {
      \     'command': 'service',
      \     'test': 'spec/services/{}_spec.rb'
      \   }
      \ }

let g:rails_gem_projections = {
      \   "activeadmin": {
      \     "app/admin/*.rb": {
      \       "command": "admin",
      \       "affinity": "model",
      \       "alternate": "app/models/{}.rb",
      \       "template": "ActiveAdmin.register {} do\nend"
      \     }
      \   }
      \ }

let g:projectionist_heuristics = {
      \   'Podfile': {
      \     'Podfile': { 'alternate': 'Podfile.lock', 'type': 'podfile' },
      \     'Podfile.lock': { 'alternate': 'Podfile' }
      \   },
      \   '*.m': {
      \     '*.h': { 'alternate': '{}.m' },
      \     '*.m': { 'alternate': '{}.h' }
      \   },
      \   '*.c': {
      \     '*.h': { 'alternate': '{}.c' },
      \     '*.c': { 'alternate': '{}.h' }
      \   },
      \   '*.cpp': {
      \     '*.h': { 'alternate': '{}.cpp' },
      \     '*.cpp': { 'alternate': '{}.h' }
      \   }
      \ }

" Vim: stuff
call extend(g:projectionist_heuristics, {
\   "*.vim|*/*.vim|_(vim)": {
\     "autoload/*.vim": {
\       "type": "autoload"
\     },
\     "UltiSnips/*.snippets": {
\       "type": "ultisnip"
\     },
\     "colors/*.vim": {
\       "type": "colorscheme"
\     },
\     "plugin/*.vim": {
\       "type": "plugin"
\     },
\     "ftdetect/*.vim": {
\       "type": "ftdetect"
\     },
\     "doc/*.txt": {
\       "type": "doc"
\     },
\     "ftplugin/*.vim": {
\       "type": "ftplugin"
\     }
\   }
\ })
