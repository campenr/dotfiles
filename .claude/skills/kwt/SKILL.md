---
name: kwt
description: Create, enter and work inside the four permanent colour-named git worktrees (red, green, blue, yellow) via kwt-create. Use whenever work should happen in a worktree, a parallel/isolated checkout, or a separate branch without disturbing the main checkout - and before running tests in any worktree.
argument-hint: "[colour] - red, green, blue or yellow"
---

Four permanent worktrees exist per repo at `<repo>/.claude/worktrees/{red,green,blue,yellow}`.
The **directory** is permanent; the branch checked out in it rotates.

## If the session is not in a repo yet, defer

`kwt-create` needs a repo — the colour trees live at `<repo>/.claude/worktrees/`,
so there is nothing to create until a repo is known. When the working directory
is not inside a git repository (e.g. it is a parent directory holding many
repos), do **not** guess which repo is meant and do **not** create a tree.
Instead:

- Note the requested colour (or "pick an idle one") and say the tree will be
  entered once the work has a repo.
- Carry on with whatever the user actually asked for.
- The moment the work settles on a repo — the user names it, or you `cd` into one
  to read or change files — run `kwt-create <colour>` from inside that repo and
  `EnterWorktree` before making any edits.

Only ask which repo if the user's request is specifically about being in a
worktree and nothing else identifies the repo.

## Use the colour trees, not ad-hoc ones

Do **not** create worktrees with `EnterWorktree`'s auto-generated names, and do
not call `git worktree add` directly. Both would litter the same
`.claude/worktrees/` directory with trees outside the colour scheme.

To put yourself in a colour tree:

1. `kwt-create <colour>` — creates it if missing (detached at `origin/<default>`,
   seeded), then prints its absolute path. Idempotent and safe to re-run; if the
   tree already exists it just repairs seeding and prints the path.
2. `EnterWorktree(path=<that path>)` — moves this session into it. Permitted
   because the tree is registered in `git worktree list` and sits under
   `.claude/worktrees/`. Trees entered by path are never auto-removed on exit.

`kwt-create --list` shows each colour and what it has checked out. Pick a colour
that is idle (detached) unless the user names one. `kwt` itself is a zsh
function for the user's interactive shell — it is **not** available to you, so
always call `kwt-create`.

## Starting work in a tree

A fresh tree is on a detached HEAD at the remote default branch. Start work with:

```
git switch -c <branch> origin/master    # or origin/main, per the repo
```

A branch can only be checked out in **one** worktree at a time; git will refuse
with "already used by worktree at ..." if another colour holds it. Stashes and
hooks are shared repo-wide, so a stash made in one tree is visible in all.

## Diagnosing a broken tree

A directory under `.claude/worktrees/` is not necessarily a worktree. Git
commands run inside a plain nested directory fall through to the enclosing repo
and report the **primary's** branch, which looks like success. `kwt-create`
checks registration via `--show-toplevel` and refuses if a non-worktree
directory is squatting on a colour — that error means an interrupted
`git worktree add`; remove the directory and retry.
