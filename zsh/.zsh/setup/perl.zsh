export PERL5LIB

add_perl5lib_path() {
  new_path="$1"
  case "$PERL5LIB" in
    '')
      PERL5LIB=$new_path
      ;;

    $new_path|*:$new_path|$new_path:*|*:$new_path:*)
      : #echo "$newpaths already in \$PERL5LIB"
      ;;
    *)
      PERL5LIB=$new_path:$PERL5LIB
      ;;
  esac
}

add_perl5lib_path $XDG_LIB_HOME/perl5

if [[ -s "${PERLBREW_ROOT:-$HOME/perl5/perlbrew}/etc/bashrc" ]]; then
  source "${PERLBREW_ROOT:-$HOME/perl5/perlbrew}/etc/bashrc"

  # Load Perlbrew completion.
  if [[ -s "${PERLBREW_ROOT:-$HOME/perl5/perlbrew}/etc/perlbrew-completion.bash" ]]; then
    source "${PERLBREW_ROOT:-$HOME/perl5/perlbrew}/etc/perlbrew-completion.bash"
  fi
fi

# Perl is slow; cache its output.
cache_file="${TMPDIR:-/tmp}/perl-cache.$UID.zsh"
perl_path="$HOME/perl5"

if [[ -f "$perl_path/lib/perl5/local/lib.pm" ]]; then
  if [[ "${(%):-%x}" -nt "$cache_file" || ! -s "$cache_file" ]]; then
    # PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
    perl -I$perl_path/lib/perl5 -Mlocal::lib=$perl_path >! "$cache_file"
  fi

  source "$cache_file"
fi

unset cache_file perl_path
