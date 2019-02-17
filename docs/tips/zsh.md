### How do I change my shell to ZSH?

```sh
chsh -s /bin/zsh
```

### Where can I find awesome 'zshrc's?

http://dotfiles.org/.zshrc (and check out the rest of the site too)

### Search backward through history

<kbd>Ctrl-R</kbd>

### Modify the most recent command:

```console
r search=replace
# example
$ mkdir my_dir
$ r mkdir=cd # this runs "cd my_dir"
```

### Open an editor (`$EDITOR`) to edit the last command:

```sh
fc
```

### Print an ASCII calendar:

```sh
cal
```

or

```sh
ncal
```

### Hashing

```sh
hash -d HASH=directory
```

then

```sh
cd ~HASH
```

- Do not use `~` in the directory, either. Use `/Users/gabe/`.
- more info: http://michael-prokop.at/blog/2008/12/01/mikas-advent-calendar-day-1/

### How do I unset a function?

```sh
unfunction <function-name>
```

### How do I do a named `hexdump`, with `nul` instead of `hexdump -C`'s `0`?

```sh
od -a
```

Also see: `man od`

### How do I re-initialize my `PATH`, so that newly-installed programs show up for autocomplete?

```sh
export PATH=$PATH
```

or inside a function:

```sh
function reinitialize {
  export PATH=$PATH
}
```

You can also use an alias, though I'd recommend against it:

```sh
alias reinitialize="export PATH=$PATH"
```

The alias will be expanded when you source the file with the alias, but in this case that doesn't matter since you want to set it to that same value anyway. Of course, if you've modified your path since that source time, then the alias will remove those modifications. Long story short: go with the function.

Completion
----------

### How do I make `compinit` (`autoload compinit && compinit`) find the directory where I store my completion scripts?

`compinit` searches the `$fpath` array of directories. Simply add your directory via:

```sh
fpath=(/my/completion/directory $fpath)
```

### How do I complete one command like another command?

Complete `g` like `git`:

```sh
compdef g=git
```

zstyle
------

### How do I delete all zstyle settings?

```sh
zstyle -d
```

For more on style, see [the ZSH docs](http://zsh.sourceforge.net/Doc/Release/zsh_21.html#SEC182).

Options
-------

Use via e.g. `setopt correct` or `unsetopt correct`

- `correct`: correct commands
- `correctall`: correct commmands **and** arguments
- `hist_reduce_blanks`: Removes meaningless whitespace in previous commands, so `echo 'asdf 1234'    ` shows up as `echo 'asdf 1234'` when you press <kbd>&uarr;</kbd> to go back in history
- `hist_ignore_all_dups`: don't store repeated commands `autocd`: type a directory name to `cd` to it, no need to type out `cd`
- `prompt_subst`: allow commands in prompt, so you can do `PS1="%{my_function%}"` and it'll work.

ZSH Variables
-------------

- `SAVEHIST`: The maximum number of history events to save in the history file.
- `HISTSIZE`: The maximum number of events stored in the internal history list.

If you use the `HIST_EXPIRE_DUPS_FIRST` option, setting `HISTSIZE` larger than the `SAVEHIST` size will give you the difference as a cushion for saving duplicated history events. (i.e., `SAVEHIST` will then be the number of unique events to save)

To see where all env variables are getting set:

```sh
zsh -xl
```

This also starts a new session.

VCS info
--------

First do `autoload -Uz vcs_info`.

Try these articles:

- http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
- http://kriener.org/articles/2009/06/04/zsh-prompt-magic
