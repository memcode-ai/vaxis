# memcode's vaxis fork

This is [vaxis](https://github.com/rockorager/vaxis) with the patches
[memcode](https://github.com/memcode-ai/memcode) needs, published as the Go
module `github.com/memcode-ai/vaxis` so memcode can depend on it without a
`replace` directive (which would break `go install`).

## Patches on top of upstream

- `vaxis: keep scrollback when the primary region grows`
- `tty: drain query replies before restoring the terminal`
- `vaxis: always reset in-band resize on exit`
- `ui: let test harnesses install scrollback appenders`
- `ui: never drop or block on Dispatch`
- `ansi: build the parser directly in the anywhere test`
- `all: rename module to github.com/memcode-ai/vaxis`

## Taking upstream changes

```sh
git remote add upstream https://github.com/rockorager/vaxis  # once
git fetch upstream
git merge upstream/main
./scripts/rename-module.sh   # renames any import upstream added
go test -race ./...
git commit -am "all: rename module in merged upstream code"  # only if the script changed files
git push
```

Never force-push `main`: memcode pins commits of this branch by
pseudo-version, so every pinned commit must stay reachable.
