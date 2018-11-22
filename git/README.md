Conifg
------

There are three configuration files under `$XDG_CONFIG_HOME/git`:

#### `config`

This is the regular configuration file with sections such as `[color]` and `[alias]`.

#### `config.private`

This is a private configuration file where identities, credentials and other "private" stuff should be placed. Example:

```dosini
[user]
  name = Captain Awesome
  email = captain.awesome@example.com

[github]
  user = CaptainAwesome
  name = Captain Awesome
```

#### `config.local`

This is a configuration file where local stuff can be placed. For example, when using GNU Stow, you can have a `macOS` package and a `linux` with different local configuration files.

Local configuration file for macOS:

```dosini
[credential]
  helper = osxkeychain
```

Local configuration file for Linux:

```dosini
[credential]
  helper = cache
```

Subcommands
-----------

### git-last

Show the last _N_ commits.

**Example:** show the last 3 commits

```sh
git last 3
```

*Stolen from [git-utils][].*

### git-wip

store a current "work in progress" commit

*Stolen from [git-utils][].*

### git-switch

Like checkout, but with auto-stash.

*Stolen from [git-utils][].*

### git-rank-contributors

*This is the version from [willgit][].*

### git-wtf

*This is the version from [willgit][]. There is another version in [git-utils][].*

### git-submodule-merge

Purges the copies of obsoleted submodule repositories.

*Stolen from [gitbits/git-submodule-misc](https://github.com/gitbits/git-submodule-misc)*

### git-cp

A convenient only subcommand for git that does [cp(1)][man-cp] and [git-add(1)][man-git-add].

*Stolen from [gitbits/git-cp](https://github.com/gitbits/git-cp)*

[willgit]: https://github.com/DanielVartanov/willgit
[git-utils]: https://github.com/ddollar/git-utils
[man-cp]: http://man7.org/linux/man-pages/man1/cp.1.html
[man-git-add]: https://www.kernel.org/pub/software/scm/git/docs/git-add.html
