# git-scripts

A collection of small scripts to make the git workflow easier

These scripts are intended for making the GitHub workflow easier.
They support a single "central" repo as well as the common dual
"upstream/fork" repo setups. In particular, both the setup recommended
by GitHub's [help on configuring remotes][] (upstream named `upstream`
and fork named `origin`) and the setup created by the GitHub's
[hub tool]() (upstream named `origin` and fork named `$GIHUB_USER`) are
supported.

Note that nothing prevents using most of these scripts with other
hosting services like GitLab.

## Installation

To install, clone the directory and run the install script:

```sh
git clone https://github.com/nicksay/git-scripts.git
cd git-scripts
./install.sh
```

This will place the scripts in `$HOME/bin`.

## Basic Usage

Since the scripts are intended for making the GitHub workflow easier,
the best usage documentation is the lifecycle of a change.

To get started, create a new branch:

```sh
git new "my-change"
```

Then, edit and commit code as normal.

When you're ready, create a pull request for your change:

```sh
git hub-pull-request
```

This will prepare your branch for a pull request by rebasing on the
latest commits from upstream, push your branch to your fork, and create
a pull request using the [hub tool][] if it's installed or open the
GitHub compare URL if not.

After your pull request is accepted, you can finish up:

```sh
git done
```

This will make sure both your local and fork repos are updated with the
latest changes from upstream and remove branches have been merged or
squashed with master, including the one you created for your change.


## Documentation

### `git hub-pull-request`

Create a GitHub pull request.

Calls `git prepare` and `git push` followed by `hub pull-request`
(if available) or opens a compare URL.


### `git hub-remotes`

Prints the GitHub upstream and fork remotes.

```sh
git hub-remotes [--upstream|--fork]
```

### `git hub-user`

Prints the GitHub user.

```sh
git hub-user
```

Finds the value from the following sources in descending order:

1. environment (`$GITHUB_USER`)
2. .git/config or ~/.gitconfig (`git config --get hub.user`)
3. ~/.config/hub (`github.com -> [0] -> user`)

If a value is not found, prompts for one and saves it to .git/config.

### `git done`

```sh
git done
```

Finishes a branch: returns to master, runs `git sync` and `git tidy`.

### `git new`

```sh
git new <branch>
```

Creates a new branch from master.

Arguments:

- `branch`: the name of the new branch to create

### `git prepare`

```sh
git prepare [upstream] [branch]
```

Prepare your current branch for a pull request.

Arguments:

- `upstream`: defaults to `git hub-remotes --upstream`
- `branch`: defaults to "master"

Fetches the latest commits from `[upstream]` and rebases on
`[upstream]/[branch]`. Automatically avoids interactive mode unless
needed and will `rebase --autosquash` all commits made with
`commit --fixup` and `commit --squash` without needing to launch an
editor.

Afterward, run `git push` to update an existing pull request on GitHub.

### `git sync`

```sh
git sync [upstream] [fork] [branch]
```

Keep your local and fork repos synced with upstream.

Arguments:

- `upstream`: defaults to `git hub-remotes --upstream`
- `fork`: defaults to `git hub-remotes --fork`
- `branch`: defaults to the current branch

Pulls the latest commits from `[upstream]/[branch]` and then pushes
to `[fork]/[branch]`. Uses `pull --prune` and `push --prune` to remove
old branch references.

### `git tidy`

```sh
git tidy [branch]
```

Deletes branches merged or squashed with a base branch.

Arguments:
- `branch`: defaults to "master"



[help on configuring remotes]: https://help.github.com/articles/configuring-a-remote-for-a-fork/
[hub tool]: https://hub.github.com/
