# A smarter help widget, this will look for
# a file before resorting to using man.
unalias run-help 2> /dev/null

# Helper functions.
# Authoload them BEFORE autoloading run-help
autoload -Uz run-help-git
autoload -Uz run-help-openssl
autoload -Uz run-help-ssh
autoload -Uz run-help-sudo
autoload -Uz run-help
