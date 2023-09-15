# dotfiles

Setup according to [this article](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

To get setup do `git clone --bare git@github.com:campenr/dotfiles.git dotfiles`, then `alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'`.

This sets up the dotfiles command as an alias for git, with the git repository configuration stored in `~/dotfiles` and the dotfiles themselves stored in `~` where you would expect them.

You can then use `dotfiles` as you would `git` to add new files, change branches, create new branches, etc.

It also helps to run `dotfiles config --local status.showUntrackedFiles no` so you don't get to see the entire contents of `~` that you don't care about when you run `dotfiles status`.
