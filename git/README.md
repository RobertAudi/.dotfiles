```text
           ███   █████
          ░░░   ░░███
  ███████ ████  ███████
 ███░░███░░███ ░░░███░
░███ ░███ ░███   ░███
░███ ░███ ░███   ░███ ███
░░███████ █████  ░░█████
 ░░░░░███░░░░░    ░░░░░
 ███ ░███
░░██████
 ░░░░░░
```

Configuration
-------------

### Configuration files

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

### git-wip

Store a current "work in progress" commit

*Stolen from [git-utils][].*

### git-wtf

*This is the version from [willgit][]. There is another version in [git-utils][].*

[willgit]: https://github.com/DanielVartanov/willgit
[git-utils]: https://github.com/ddollar/git-utils
