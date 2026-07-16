# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles managed with [dotdrop](https://github.com/deadc0de6/dotdrop), vendored as a git
submodule at `./dotdrop`. The actual dotfiles live under `dotfiles/`; `config.yaml` tells dotdrop
which files map to which destinations, and for which machine "profiles" each file should be
installed.

Never edit anything under `./dotdrop` — that's the third-party dotdrop tool source, kept in sync
via `git submodule`, not hand-authored content for this repo.

## Commands

All dotdrop operations go through the wrapper script `./dotdrop.sh`, which auto-updates the
`dotdrop` submodule to its latest remote commit before running (set `DOTDROP_AUTOUPDATE=no` to
skip this, e.g. when offline or iterating quickly) and requires a Python 3 environment with
dotdrop's dependencies installed (see `environment.yml`, conda env `dotdrop_env`).

```bash
# Install dotfiles for a given machine profile into $HOME
./dotdrop.sh install -p <profile>

# Show a diff between what's tracked here and what's actually on disk
./dotdrop.sh compare -p <profile>

# Pull local changes made directly to installed dotfiles back into dotfiles/
./dotdrop.sh update -p <profile>

# List dotfiles tracked for a profile
./dotdrop.sh files -p <profile>
```

Profiles currently defined in `config.yaml`: `hypnotoad`, `zoidberg`, `calculon`, `bender`,
`cygwin` — each is a specific real machine, not an OS family, so behavior differs even between
two Linux boxes (e.g. `hypnotoad` vs `bender`).

## Architecture

- **`config.yaml`** (repo root) is the source of truth. Each entry under `dotfiles:` (keyed
  `f_<name>`) declares a `src:` path relative to `dotfiles/` and a `dst:` path under `~`, plus
  optional `chmod:`. Each entry under `profiles:` lists which `f_*` keys get installed for that
  machine.
- **`dotfiles/`** holds the actual file contents, one file per dotdrop entry (e.g. `bashrc`,
  `bash_aliases`, `bash_functions`, `gitconfig`, `ssh/config`, `emacs.d/init.el`,
  `emacs.d/emacs-config.org`, `bin/c5.sh`).
- **Per-profile templating**: several files contain machine-specific sections using dotdrop's
  Jinja-based templating, gated on the `profile` variable:
  ```
  {%@@ if profile == "calculon" @@%}
  ...macOS/Homebrew-specific config...
  {%@@ elif profile == "zoidberg" @@%}
  ...WSL-specific config...
  {%@@ endif @@%}
  ```
  This pattern appears in `bashrc`, `bash_profile`, `bash_aliases`, `Xresources`,
  `emacs.d/emacs-config.org`, and `ssh/config`. When editing one of these, check for existing
  `{%@@ if profile == ... @@%}` blocks before adding logic that should only apply to one machine.

### Adding a new dotfile

1. Add the file under `dotfiles/`.
2. Add a corresponding `f_<name>:` entry under `dotfiles:` in `config.yaml` with `src`/`dst`.
3. Add that key to the `dotfiles:` list of every profile that should receive it.

### Machine profile notes

- `calculon` — macOS; uses Homebrew (`brew shellenv`, `brew --prefix`), Miniforge/conda, Rust
  (`~/.cargo/env`), and MacOS-specific `XAuthLocation`/`UseKeychain` SSH settings.
- `bender` — Linux; Miniconda, KPP compiler `PATH`/`KPP_HOME` setup.
- `hypnotoad` — Linux; Miniforge, Ruby gems path, KPP setup.
- `zoidberg` — WSL under Windows; Miniforge, X11-forwarding-to-Windows (`LIBGL_ALWAYS_INDIRECT`),
  detects both the WSL and Windows-host IPs.
- `cygwin` — Windows/Cygwin; sets `USER`/`DISPLAY`, no conda/KPP setup.

There is no separate build, lint, or test suite for this repo's own content (`dotfiles/`,
`config.yaml`) — it is shell/config templates, validated by actually running
`./dotdrop.sh compare`/`install` against a profile.
