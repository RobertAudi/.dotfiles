git-delete-merged-branches(1) -- Delete merged branches
=====================================================

## SYNOPSIS

`git-delete-merged-branches`

## DESCRIPTION

  Deletes all branches merged in to current HEAD. Does not delete *master*, even if run from a branch that is
  a descendant of *master*.

## EXAMPLES

    $ git delete-merged-branches

## AUTHOR

Written by Jesús Espino &lt;<jespinog@gmail.com>&gt;
