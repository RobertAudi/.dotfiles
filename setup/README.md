Homebrew
--------

The `brew.sh` script will update `brew` or install it if needed:

```console
$ ./brew.sh
```

Dependencies are managed using [Homebrew Bundle][brew-bundle] and are organized in multiple ["bundles"](./Homebrew) (files with the `.brewfile` extension).

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

[brew-bundle]: https://github.com/Homebrew/homebrew-bundle

Rust
----

### Install

The `rust.sh` script will install Rust using [rustup.rs][]:

```console
$ ./rust.sh
```

[rustup.rs]: https://rustup.rs/

### Packages

```console
$ ./cargo-packages.sh
```

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

Alacritty
---------

```console
$ ./alacritty.sh
```
