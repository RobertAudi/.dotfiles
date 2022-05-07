" Plugin: tpope/vim-projectionist
" Description: Granular project configuration
" URL: https://github.com/tpope/vim-projectionist

" Rails {{{
" ------------------------------------------------------------------------------

" Prefere *_spec.rb rather than *_test.rb with :A
let g:rails_projections = {
      \   'app/*.rb': {
      \     'alternate': 'spec/{}_spec.rb'
      \   },
      \   'app/controllers/*_controller.rb': {
      \     'alternate': ['spec/requests/{}_spec.rb', 'spec/requests/{}_request_spec.rb', 'spec/requests/{}_controller_spec.rb', 'spec/{}_controller_spec.rb']
      \   },
      \   'spec/*_spec.rb': {
      \     'alternate': 'app/{}.rb'
      \   },
      \   'spec/requests/*_spec.rb': {
      \     'alternate': ['app/controllers/{}_controller.rb', 'app/controllers/{}.rb']
      \   },
      \   'spec/requests/*_request_spec.rb': {
      \     'alternate': ['app/controllers/{}_controller.rb', 'app/controllers/{}.rb']
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
      \   'activeadmin': {
      \     'app/admin/*.rb': {
      \       'command': 'admin',
      \       'affinity': 'model',
      \       'alternate': 'app/models/{}.rb',
      \       'template': 'ActiveAdmin.register {} do\nend'
      \     }
      \   }
      \ }

" ------------------------------------------------------------------------------ }}}

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

" Modeline {{{
" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
