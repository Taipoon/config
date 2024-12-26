#!/bin/bash

REMOTE="origin"
git fetch --prune "$REMOTE"
local_branches=$(git branch --format '%(refname:short)' | grep -vE '^(main|master)$')

for branch in $local_branches; do
	if git ls-remote --exit-code --heads "$REMOTE" "$branch" > /dev/null 2>&1; then
		continue
	else
		echo "Deleting local branch: $branch"
		git branch -D "$branch"
	fi
done
