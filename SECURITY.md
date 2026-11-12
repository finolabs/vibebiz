# Security Policy

## Scope

vibebiz is a skills-only Claude Cowork plugin: instructions, templates and content packs. It ships no server and no runtime scripts (development tooling under `scripts/` does not ship in the plugin). Security issues therefore mostly look like:

- an instruction or template that makes the plugin write, overwrite or share a user's file when it should not (for example overwriting an existing file, or making an Artifact or image public);
- an instruction that sends business data somewhere other than the user's workspace and Google Drive;
- a file in the repository that contains a secret, credential, or real personal or company data;
- a weakness in the build or check scripts used by maintainers.

## Reporting a vulnerability

Please do **not** open a public issue for a security problem.

1. Use GitHub's private vulnerability reporting on this repository ("Security" tab, "Report a vulnerability"), once the repository has it enabled; or
2. contact the repository owner privately.

Include what you saw, the steps to reproduce, the plugin version, and what you expected. Do not include real business data in the report.

## What to expect

- An acknowledgement within 7 days.
- An assessment and, where the report is valid, a fix in the next release, recorded in `CHANGELOG.md` without exposing details until a fix is available.
- Credit in the changelog if you want it.

## If you find a secret in the repository

Tell the maintainers the file and the kind of secret only; do not copy it or try to use it. It will be rotated and removed.

## Supported versions

Only the latest released version receives fixes.
