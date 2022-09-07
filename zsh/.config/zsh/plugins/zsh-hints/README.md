zsh-hints
=========

`zsh-hints` is a small helper utility that displays hints right below the command you are typing. Intended use is to make trivia that are not suitable for completing, like zsh flags, available without interfering with your work flow. An example says more than thousand words. While typing a command, you suddenly are not sure about the parameter expansion flags. Pressing `<CTRL-X><f>` displays the information, and you can continue to write your command without interruption:

```
% for i in *; do print ${(on<CTRL-X><f>
@         ▶ array elements
c         ▶ count elements of array/string
k,v       ▶ returns keys, values of associative array
u         ▶ unique, deduplicate entries
A(A)      ▶ create (associative) array, useful with
            ${(A)...=...}
s:string: ▶ field splitting at string
f         ▶ split at newlines (ps:\\n:)
z         ▶ (Z:opt:) split result into shell words
0         ▶ split with 0-bytes: ps:\\0:
j:string: ▶ join words of array with string as separator
F         ▶ join words of array with newlines (pj:\\n:)
w         ▶ count words, use s to define word delimiter
W         ▶ count words, double delimiters count doubly
i         ▶ sort case insensitive. Combine with n, O
n         ▶ sort numerically
o         ▶ sort in ascending order
O         ▶ reverse sort order
a         ▶ sort in array index order (with O reversed)
U         ▶ convert to uppercase
L         ▶ convert to lowercase
V         ▶ make special characters visible
   ...14 hints omitted.
```

Note that this is on a rather small terminal, some hints needed to be omitted, and there is a line wrapping at A(A). It is really easy to change the hints files, so you can just make a list of things you are currently learning.

The hints, or definitions, are read from a file, where the characters before the first space are considered as a key, and the rest as the explanation. This means that it is extremely easy to create and use your own hint files.

The output is adjusted to the size of the terminal, and some of its looks are configurable.

The basic setup
---------------

To make use of this script, you need to do the following things:

1. autoload `zsh-hints`
2. Make a `hints`-file available
3. Set up some key bindings in `~/.zshrc`
4. Optionally, configure some decorations

First, the file `zsh-hints` needs to be `autoload`ed. If you don't have a directory for autoloadable zsh-functions yet, you need to set one up. Putting this in `~/.zshrc` will autoload all files in `~/.zfun`:

```sh
fpath=(~/.zfun $fpath)
autoload ~/.zfun/*(:t)
```

For the hint files, without any configuration, zsh-hints will look in `$XDG_DATA_HOME/zsh`, or in `~/.local/share/zsh`. Just drop 'em there, and you will be fine.

Then, we need to tell `zsh` every time an interactive session is started. For every hint file you want to dedicate a keyboard shortctut to, there you need to make some arrangements. To make the `param.hints` file available when pressing `CTRL-x p`, you first need to tell that `zsh-hints-param` really is just another name of `zsh-hints` with `zle -N zsh-hints-param zsh-hints`. Once that is set, you can call this function with `CTRL-x p` through a key binding with `bindkey "^Xp" zsh-hints-param`.

These lines are used by the author to enable the included hint-files:

```sh
zle -N zsh-hints-param zsh-hints
bindkey "^Xp" zsh-hints-param
zle -N zsh-hints-paramflags zsh-hints
bindkey "^Xf" zsh-hints-paramflags
zle -N zsh-hints-glob zsh-hints
bindkey "^Xg" zsh-hints-glob
```

The effect of this is, that `zsh-hints` will be called under the name `zsh-hints-param`. Without any further configuration, `zsh-hints` will try to use a file `param.hints` in the directory `$XDG_DATA_HOME/zsh`.

Configuring looks
-----------------

The first thing you might want to adjust, is how the function behaves if the contents of the file does not fit within the terminal window. The style `margin` determines the minimum amount of the normal terminal that will remain visible. If not set, it the default is 6 lines.

```sh
zstyle ':zsh-hints:*:' margin 8
zstyle ':zsh-hints:param:' verbose no
```

When lines need to be omitted due to space constraints, the verbose option takes one line to tell how many lines needed to be omitted from the result. This is enabled by default, and can be disabled like this:

```sh
zstyle ':zsh-hints:*:' verbose no
```

The separators separating the keys from their explanation are configurable. Without configuration, the primary separator, that is, when there is no newline since the key, is a `#`. By default, the secondary separator takes on the value of the primary separator. I have mine currently set as follows:

```sh
zstyle ':zsh-hints:*:' pri_sep ▶
zstyle ':zsh-hints:param:' sec_sep " "
```

Overriding the default file location
------------------------------------

`zsh-hints` will look in a configurable directory for a file named after the function with a configurable extension. These settings can be made for all hint files, or for a specific one. Alternatively, you can specify a file to use directly.

If not explicitly set, the directory `${XDG_DATA_HOME}/zsh` will be used, and if `$XDG_DATA_HOME` is not set, its default location `~/.local/share/zsh` is assumed. This can be overridden as follows:

```sh
zstyle ':zsh-hints:*:' dir "/path/to/dir"
zstyle ':zsh-hints:param:' dir "/path/to/dir2"
```

In this directory, a file is attempted to be found with the name of the hint, with the extension `.hints`. The extension can be disabled or changed by the following directives:

```sh
zstyle ':zsh-hints:*:' ext "txt"
zstyle ':zsh-hints:glob:' ext ""
```

To set a file path directly, use:

```sh
zstyle ':zsh-hints:param:' file "/path/to/file"
```

Making your own hints-file
--------------------------

Making the hints file is straight forward: The only mark-up is the first word of the line. When you want to make this available, store the file with the directions of the previous paragraph, and make a new key binding:

```sh
zle -N zsh-hints-FILE zsh-hints
bindkey "keybind" zsh-hints-FILE
```

License
-------

Written by Joep van Delft, licensed under the ZSH-license.
