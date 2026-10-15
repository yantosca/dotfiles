# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles managed with [dotdrop](https://github.com/deadc0de6/dotdrop), vendored as a git submodule at `./dotdrop`. The actual dotfiles live under `dotfiles/`; `config.yaml` tells dotdrop which files map to which destinations, and for which machine "profiles" each file should be installed.

Never edit anything under `./dotdrop` — that's the third-party dotdrop tool source, kept in sync via `git submodule`, not hand-authored content for this repo. It is only ever bumped (commits like "Dotdrop submod update to <sha>").

## Commands

All dotdrop operations go through the wrapper script `./dotdrop.sh`, which requires a Python 3 environment with dotdrop's dependencies installed (see `environment.yml`, conda env `dotdrop_env`). `dotfiles/bash_aliases` defines `alias dotdrop="~/repos/dotfiles/dotdrop.sh --cfg=~/repos/dotfiles/config.yaml"`.

```bash
# Show a diff between what's tracked here and what's actually on disk (read-only)
./dotdrop.sh compare -p <profile>

# Install dotfiles for a given machine profile into $HOME (backs up existing files)
./dotdrop.sh install -p <profile>

# Pull local changes made directly to installed dotfiles back into dotfiles/
./dotdrop.sh update -p <profile>

# List dotfiles tracked for a profile
./dotdrop.sh files -p <profile>
```

- `dotdrop.sh` runs `git submodule update --remote dotdrop` on every invocation, which moves the submodule and leaves the working tree dirty. Prefix commands with `DOTDROP_AUTOUPDATE=no` unless the goal is to bump the submodule.
- Without `-p`, dotdrop uses the hostname as the profile. Harvard Cannon nodes (e.g. `holy*.rc.fas.harvard.edu`) match no profile, so always pass `-p` explicitly.
- Use `compare` to check rendered output. `install` and `update` write files (in `$HOME` and `dotfiles/` respectively), so run them only when asked.

Profiles currently defined in `config.yaml`: `hypnotoad`, `zoidberg`, `calculon`, `bender`, `cygwin` — each is a specific real machine, not an OS family, so behavior differs even between two Linux boxes (e.g. `hypnotoad` vs `bender`).

There is no separate build, lint, or test suite for this repo's own content (`dotfiles/`, `config.yaml`) — it is shell/config templates, validated by running `./dotdrop.sh compare` against a profile.

## Architecture

- **`config.yaml`** (repo root) is the source of truth. Each entry under `dotfiles:` (keyed `f_<name>`) declares a `src:` path relative to `dotfiles/` and a `dst:` path under `~`, plus optional `chmod:`. Each entry under `profiles:` lists which `f_*` keys get installed for that machine.
- **`dotfiles/`** holds the actual file contents, one file per dotdrop entry (e.g. `bashrc`, `bash_aliases`, `bash_functions`, `gitconfig`, `ssh/config`, `emacs.d/init.el`, `bin/c5.sh`).
- **Per-profile templating**: several files contain machine-specific sections using dotdrop's Jinja-based templating with custom delimiters (`{%@@ ... @@%}` for blocks, `{{@@ ... @@}}` for variables), gated on the `profile` variable:
  ```
  {%@@ if profile == "calculon" @@%}
  ...macOS/Homebrew-specific config...
  {%@@ elif profile == "zoidberg" @@%}
  ...WSL-specific config...
  {%@@ endif @@%}
  ```
  This pattern appears in `bashrc`, `bash_profile`, `bash_aliases`, `gitconfig`, `Xresources`, and `ssh/config`. When editing one of these, extend the existing `{%@@ if profile == ... @@%}` chain rather than adding a per-host file. These files are not valid shell until rendered, so don't run `bash -n` or similar on them directly; use `compare` instead.
- **`.gitattributes`** forces LF line endings everywhere except `dotfiles/minttyrc` (CRLF, for Cygwin) and marks `dotfiles/barrier.sgc` as binary.

### Emacs config

`dotfiles/emacs.d/init.el` only calls `(org-babel-load-file "~/.emacs.d/emacs-config.org")`. `emacs-config.org` is no longer tracked here; it is maintained in the separate `yantosca/emacs-config` repo, so Emacs configuration changes belong there, not in this repo.

### Adding a new dotfile

1. Add the file under `dotfiles/`.
2. Add a corresponding `f_<name>:` entry under `dotfiles:` in `config.yaml` with `src`/`dst`.
3. Add that key to the `dotfiles:` list of every profile that should receive it.

### Machine profile notes

- `calculon` — macOS; uses Homebrew (`brew shellenv`, `brew --prefix`), Miniforge/conda, Rust (`~/.cargo/env`), `emacsclient` as the git editor, and macOS-specific `XAuthLocation`/`UseKeychain` SSH settings.
- `bender` — Linux; Miniconda, KPP compiler `PATH`/`KPP_HOME` setup.
- `hypnotoad` — Linux; Miniforge, Ruby gems path, KPP setup.
- `zoidberg` — WSL under Windows; Miniforge, X11-forwarding-to-Windows (`LIBGL_ALWAYS_INDIRECT`), detects both the WSL and Windows-host IPs.
- `cygwin` — Windows/Cygwin; sets `USER`/`DISPLAY`, no conda/KPP setup.

## Conventions

- Shell files use a GEOS-Chem-style ProTeX header (`#BOP` / `!MODULE:` / `!DESCRIPTION:` / `#EOP` / `#BOC`); keep it when editing and match it in new shell files.
- Commit subjects name the dotfile by its installed name or repo path (e.g. "Add boslogin and holylogin macros to ssh/config").
