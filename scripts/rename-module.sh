#!/bin/sh
# Rename the module from go.rockorager.dev/vaxis to github.com/memcode-ai/vaxis:
# the go.mod module line and every import of it. Re-run after merging upstream
# (see MEMCODE.md); it is a no-op when nothing references the old path.
set -eu
cd "$(dirname "$0")/.."
old=go.rockorager.dev/vaxis
new=github.com/memcode-ai/vaxis
go mod edit -module "$new"
grep -rl --include='*.go' "\"$old" . | while IFS= read -r f; do
	sed -i.bak "s#\"$old\([/\"]\)#\"$new\1#g" "$f"
	rm "$f.bak"
done
gofmt -w .
