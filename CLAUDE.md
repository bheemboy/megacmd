# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A minimal Docker image that packages MEGAcmd (MEGA's CLI sync client) on `debian:13-slim`, plus a `docker-compose.yml` for running it as a long-lived sync daemon. There is no application code, tests, or linting — the whole project is `Dockerfile`, `docker-compose.yml`, and `README.md`.

## Commands

Build and push (from the comment at the top of `Dockerfile`; the date tag uses PowerShell syntax, use `$(date +%Y.%m.%d)` on Linux):

```
docker build -t bheemboy/megacmd:latest -t bheemboy/megacmd:$(date +%Y.%m.%d) .
docker push --all-tags bheemboy/megacmd
```

Run: `docker compose up -d`, then inside the container run `mega-login` and `mega-sync` (see README).

## Architecture notes

- `Dockerfile` downloads the official MEGAcmd `.deb` for Debian 13 amd64 from mega.nz, installs it (`dpkg -i || true` followed by `apt-get install -f` to resolve deps), and sets `ENTRYPOINT ["mega-cmd-server"]` so the container runs the MEGAcmd daemon.
- `docker-compose.yml` mounts `/etc/machine-id` read-only (MEGAcmd ties its session/credentials to the machine id — without this the login does not persist across container recreation), `/root/.megaCmd` for persisted config/session, and a host directory under `/root/MEGA/` as the sync target.
- The compose snippet in `README.md` is a copy of `docker-compose.yml`; keep the two in sync when changing volumes.
