#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for dotfile in "${SCRIPT_DIR}"/.??* ; do
    [[ "$dotfile" == "${SCRIPT_DIR}/.git" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.github" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.DS_Store" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.gitconfig" ]] && continue

    ln -fnsv "$dotfile" "$HOME"
done

# .gitconfig はテンプレートから生成（個人情報を対話的に入力）
GITCONFIG_TEMPLATE="${SCRIPT_DIR}/.gitconfig"
GITCONFIG_DEST="$HOME/.gitconfig"

if [ -f "$GITCONFIG_DEST" ]; then
    printf ".gitconfig already exists. Overwrite? [y/N]: "
    read answer
    case "$answer" in
        [yY]*) ;;
        *) echo "Skipped .gitconfig"; exit 0 ;;
    esac
fi

printf "Git user name: "
read git_name
printf "Git email: "
read git_email

sed -e "s/__GIT_USER_NAME__/$git_name/" \
    -e "s/__GIT_USER_EMAIL__/$git_email/" \
    "$GITCONFIG_TEMPLATE" > "$GITCONFIG_DEST"

echo "Created $GITCONFIG_DEST"
