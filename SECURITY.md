# Security Policy

This repository contains personal shell/editor/SSH configuration files (dotdrop-managed
dotfiles). It has no application code, so there is no version support matrix.

## Reporting a vulnerability or exposed secret

If you find a security issue in these dotfiles — for example, a committed credential, an
overly permissive SSH/config setting, or an unsafe pattern in one of the scripts under
`dotfiles/bin` — please do not open a public issue. Instead, use GitHub's private vulnerability
reporting: https://github.com/yantosca/dotfiles/security/advisories/new

## Scope

The `dotdrop/` directory is a vendored third-party submodule
([deadc0de6/dotdrop](https://github.com/deadc0de6/dotdrop)). Report vulnerabilities in dotdrop
itself upstream, not here.
