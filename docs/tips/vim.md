### How do I reselect the most recently selected visual block?

```vim
gv
```

### How do I go to column 4 (or any other column) in the current line?

```vim
4|
```

### How do I autocomplete the current line (not word)?

<kbd>Ctrl-x l</kbd> will autocomplete as much of the current line as possible. Say you have a line like: "Given I sign up", then you can type "Given", press <kbd>Ctrl-x l</kbd>, and it'll autocomplete to "Given I sign up" (if that's the only Given line), or if other lines match, they'll show up in a standard autocomplete menu. This is really helpful in cucumber feature files. (Thanks, Harold)

### How do I open a tag (e.g. a method name)?

<kbd>Ctrl-]</kbd> when the cursor's on the tag (like jumping into a cave)

### How do I get back once I've jumped into a tag?

<kbd>Ctrl-o</kbd> (jump Out) or <kbd>Ctrl-6</kbd> (which will jump to the alternate file, which in this case is the file you were in. Apparently this is because <kbd>Ctrl-^</kbd> is the real mapping, but <kbd>Ctrl-Shift-6</kbd> is too many keys.)

### How do I open a tag in a split?

<kbd>Ctrl-w ]</kbd>. See `:help window-tag` for more awesomeness.

### How do I jump back to a previous cursor position (maintained across files)?

<kbd>Ctrl-o</kbd>. See next question for more detail.

### How do I jump forward to a newer cursor position (maintained across files)?

<kbd>Ctrl-i</kbd>. <kbd>Ctrl-i</kbd> is the opposite of <kbd>Ctrl-o</kbd>; think of your cursor positions as a list, like browser history. <kbd>Ctrl-o</kbd> moves back, <kbd>Ctrl-i</kbd> moves forward.
