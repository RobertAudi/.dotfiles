git-undo(1) -- Remove latest commits
====================================

## SYNOPSIS

`git-undo` [&lt;commitcount&gt;]

## DESCRIPTION

  Removes the latest commits.

## OPTIONS

  &lt;commitcount&gt;

  Number of commits to remove. Defaults to *1*, thus remove the latest commit.

## EXAMPLES

  Removes the latest commit.

    $ git undo

  Remove the latest 3 commits:

    $ git undo 3

## AUTHOR

Written by Kenneth Reitz &lt;<me@kennethreitz.com>&gt; and Nick Lombard &lt;<github@jigsoft.co.za>&gt;
