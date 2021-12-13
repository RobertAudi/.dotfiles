...
===

This repository contains my dotfiles managed by [GNU Stow][stow].

Table of Contents
-----------------

- [Toolchain](#toolchain)
- [Usage](#usage)
- [The setup script](#the-setup-script)
- [Homebrew](#homebrew)
  - [Install/Update](#homebrew-install-update)
  - [Packages](#homebrew-packages)
- [License](#license)

Toolchain
---------

- [GNU Stow][stow]: Manage bundles of dotfiles and symlink them to the home directory
- [Homebrew][brew]: Package manager for macOS
- [Homebrew Bundle][brew-bundle]: Bundler for dependencies from Homebrew, Homebrew Cask and the Mac App Store
- [mas][]: Mac App Store command line interface
- [Iterm2][iterm2]: Terminal emulator for macOS
- [Zsh][zsh]: Unix shell
- [Zinit][zinit]: Flexible Zsh plugin manager
- [tmux][]: Terminal multiplexer
- [ghq][]: Manage remote repository clones
- [fzf][]: A command-line fuzzy finder
- [Universal Ctags][ctags]: A maintained ctags implementation
- [Neovim][neovim]: Vim-based text editor
- [TextMate][]: Powerful and customizable GUI text editor for macOS
- [Hammerspoon][hammerspoon]: Powerful macOS automation tool

...and a bunch more...

Usage
-----

**Don't use this as your dotfiles. Just don't.** This setup is highly customized for my needs specifically. That's not a restriction or anything like that, it's just an advice.

A better approach would be to browse the files and steal bits and pieces that you might find useful, and don't hesitate to create an issue if you have any questions and/or you found a bug, or for any reason really.

The setup script
----------------

There is a [script][setup-script] to install and setup some of the tools. To be able to use it, you need to stow the "setup" bundle:

```console
$ stow setup
```

Homebrew
--------

<h3 id="homebrew-install-update">Install/Update</h3>

Use the [`setup`][setup-script] script to update Homebrew or install it if needed:

```console
$ setup brew
```

If you just want to update brew packages (including casks), use the [`update`][update-script] script:

```console
$ update brew
```

<h3 id="homebrew-packages">Packages</h3>

Packages and dependencies are managed using [Homebrew Bundle][brew-bundle] and are organized in multiple ["bundles"](./Homebrew) (files with the `.brewfile` extension).

To install a bundle, you need to specify its file to the `brew bundle` command:

```console
$ brew bundle install --file="./Homebrew/common.brewfile"
```

Or you can install all bundles:

```zsh
# In ZSH:
for f in ./Homebrew/*.brewfile(:A); do
  brew bundle install --file="$f"
done
```

License
-------

<details>
  <summary>
    <a href="http://www.wtfpl.net/" rel="nofollow">WTFPL</a> – Do What the Fuck You Want to Public License
  </summary>
  <br>

```text
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2019 Robert Audi

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.
```

</details>

[stow]: https://www.gnu.org/software/stow/
[brew]: https://brew.sh/
[brew-bundle]: https://github.com/Homebrew/homebrew-bundle
[mas]: https://github.com/mas-cli/mas
[iterm2]: https://iterm2.com/
[zsh]: https://zsh.sourceforge.io/
[zinit]: https://github.com/zdharma-continuum/zinit
[tmux]: http://tmux.github.io/
[ghq]: https://github.com/motemen/ghq
[fzf]: https://github.com/junegunn/fzf
[ctags]: https://ctags.io
[neovim]: https://neovim.io/
[TextMate]: https://macromates.com/
[hammerspoon]: https://www.hammerspoon.org/

[setup-script]: ./setup/.local/bin/setup
[update-script]: ./zsh/.zsh/functions/update
