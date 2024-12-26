#!/bin/bash

# チェックしたいリモートリポジトリ名
REMOTE="origin"

# チェックするリモートブランチ名のリスト（必要に応じて変更可能）
BRANCH_CANDIDATES=("main" "master" "develop")

# 現在のローカルブランチ名を取得
LOCAL_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# ローカルブランチ名が空でないか確認
if [ -z "$LOCAL_BRANCH" ]; then
  echo "Error: Failed to determine the current local branch."
  exit 1
fi

# ローカルブランチと一致するリモートブランチを探す
for BRANCH in "${BRANCH_CANDIDATES[@]}"; do
  if [ "$LOCAL_BRANCH" == "$BRANCH" ]; then
    # リモートにブランチが存在するか確認
    if git ls-remote --exit-code --heads "$REMOTE" "$BRANCH" > /dev/null 2>&1; then
      echo "Pulling from remote branch '${BRANCH}' corresponding to local branch '${LOCAL_BRANCH}'..."
      git pull "$REMOTE" "$BRANCH"
      exit 0
    else
      echo "Error: The remote branch '${BRANCH}' does not exist in the repository ($REMOTE)."
      exit 1
    fi
  fi
done

# 一致するローカルブランチが見つからない場合
echo "Error: Local branch '${LOCAL_BRANCH}' does not match any of the defined branch candidates (${BRANCH_CANDIDATES[*]})."
exit 1
