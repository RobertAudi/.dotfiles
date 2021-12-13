Setup
=====

Table of Contents
-----------------

- [Rust](#rust)
  - [Install/Update](#rust-install-update)
  - [Packages](#rust-packages)
- [Alacritty](#alacritty)
  - [Requirements](#alacritty-requirements)
  - [Install/Update](#alacritty-install-update)

Rust
----

<h3 id="rust-install-update">Install/Update</h3>

Use the `setup` script to install Rust using [rustup.rs][]:

```console
$ setup rust
```

Use the `setup` script to install/update default cargo packages:

```console
$ setup cargo-packages
```

[rustup.rs]: https://rustup.rs/

<h3 id="rust-packages">Packages</h3>

- [cargo-update][]: A cargo subcommand for checking and applying updates to installed executables
- [genact][]: 🌀 A nonsense activity generator – [svenstaro.github.io/genact](https://svenstaro.github.io/genact/)
- [git-brws][]: Command line tool to browse a page for repository, file, commit or diff.
- [git-journal][]: The Git Commit Message and Changelog Generation Framework 📖
- [remote][]: 📡 Generate remote repository strings
- [commentective][]: 🔮 CLI tool to locate comments and commented out code in your source code ("comment detective")
- [eureka][]: 💡 CLI tool to input and store your ideas without leaving the terminal
- [runiq][]: An efficient way to filter duplicate lines from input, à la uniq.
- [clog-cli][]: Generate beautiful changelogs from your Git commit history
- [ptags][]: A parallel universal-ctags wrapper for git repository
- [checkpwn][]: Check [Have I Been Pwned](https://haveibeenpwned.com/) and see if it's time for you to change passwords.
- [simple-http-server][]: Simple http server in Rust
- [fw][]: Workspace productivity booster
- [eva][]: Simple calculator REPL, similar to bc(1), with syntax highlighting and persistent history

Alacritty
---------

[Alacritty][alacritty] is a GPU-accelerated terminal emulator written in Rust.

<h3 id="alacritty-requirements">Requirements</h3>

To install Alacritty, you need to have [ghq][] installed. If you haven't done so already, just run the [`setup`][setup-script] script:

```console
$ setup ghq
```

<h3 id="alacritty-install-update">Install/Update</h3>

Use the [`setup`][setup-script] script to install/update Alacritty:

```console
$ setup alacritty
```

This will do several things:

- Run the Rust [setup script](./rust.setup.sh)
- Clone or update the [Alacritty git repository][alacritty]
- Compile `Alacritty.app`
- Copy the compiled application to `/Applications`
- Generate the Alacritty manpage and copy it to `$XDG_DATA_HOME/man/man1`
- Copy the ZSH and Bash completion files to the right place

You can take a look at the [`alacritty.setup.sh`](./alacritty.setup.sh) if you want to see all the details.

[cargo-update]: https://github.com/nabijaczleweli/cargo-update
[genact]: https://github.com/svenstaro/genact
[git-brws]: https://github.com/rhysd/git-brws
[git-journal]: https://github.com/saschagrunert/git-journal
[remote]: https://github.com/casey/remote
[commentective]: https://github.com/simeg/commentective
[eureka]: https://github.com/simeg/eureka
[runiq]: https://github.com/whitfin/runiq
[clog-cli]: https://github.com/clog-tool/clog-cli
[ptags]: https://github.com/dalance/ptags
[checkpwn]: https://github.com/brycx/checkpwn
[simple-http-server]: https://github.com/TheWaWaR/simple-http-server
[fw]: https://github.com/brocode/fw
[eva]: https://github.com/NerdyPepper/eva

[alacritty]: https://github.com/jwilm/alacritty
[ghq]: https://github.com/motemen/ghq
[setup-script]: ./.local/bin/setup
[update-script]: ../zsh/.zsh/functions/update
