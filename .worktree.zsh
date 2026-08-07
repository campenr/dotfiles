# Colour-named git worktrees, for any repo.
#
# Four permanent worktrees live under <repo>/.claude/worktrees/, named red,
# green, blue and yellow. The *directory* is permanent; the branch checked out
# in it rotates. Inside a worktree git behaves normally, so start work with
# `git switch -c my-branch origin/master`.
#
#   kwt          list the colours and what each has checked out
#   kwt red      cd into red, creating and seeding it first if missing
#
# All the real work lives in ~/.local/bin/kwt-create, which coding agents can
# also call -- they do not load ~/.zshrc, so a shell function would be
# invisible to them. This wrapper exists only because a child process cannot
# change its parent shell's directory.
#
# Worth remembering, since all trees share one .git:
# - A branch can be checked out in only one worktree at a time.
# - Stashes are shared repo-wide; a stash made in red is visible in blue.
# - Hooks are shared, so pre-commit is installed once for all trees.
# In kraken-core specifically: all trees share the ~/.virtualenvs/kraken
# virtualenv, and test database names are NOT per-worktree, so run pytest in
# one tree at a time.

kwt() {
    if [[ -z "$1" ]]; then
        kwt-create --list
        return $?
    fi

    local tree
    tree=$(kwt-create "$1") || return $?
    cd "$tree"
}

_kwt() { compadd -- $(kwt-create --colours) }
compdef _kwt kwt
