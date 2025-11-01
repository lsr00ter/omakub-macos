#!/bin/zsh

# Check if git is already configured
GIT_USER_NAME=$(git config --global user.name 2>/dev/null)
GIT_USER_EMAIL=$(git config --global user.email 2>/dev/null)

if [[ -n "$GIT_USER_NAME" && -n "$GIT_USER_EMAIL" ]]; then
    echo "✓ Git is already configured:"
    echo "  Name:  $GIT_USER_NAME"
    echo "  Email: $GIT_USER_EMAIL"
    echo ""

    SKIP_CHOICE=$(gum choose "Keep current configuration" "Change configuration" --header "Git identification")

    if [[ "$SKIP_CHOICE" == "Keep current configuration" ]]; then
        export OMAKUB_USER_NAME="$GIT_USER_NAME"
        export OMAKUB_USER_EMAIL="$GIT_USER_EMAIL"
        echo "✓ Using existing git configuration"
        return 0
    fi

    # User wants to change, use existing values as defaults
    DEFAULT_NAME="$GIT_USER_NAME"
    DEFAULT_EMAIL="$GIT_USER_EMAIL"
else
    echo "Enter identification for git and autocomplete..."

    # Get system name (macOS equivalent of getent)
    SYSTEM_NAME=$(dscl . -read /Users/"$USER" RealName | sed -n 's/^ //g;2p')

    # Fallback to USER if RealName is empty
    if [[ -z "$SYSTEM_NAME" || "$SYSTEM_NAME" == "RealName:" ]]; then
        SYSTEM_NAME="$USER"
    fi

    DEFAULT_NAME="$SYSTEM_NAME"
    DEFAULT_EMAIL=""
fi

export OMAKUB_USER_NAME=$(gum input --placeholder "Enter full name" --value "$DEFAULT_NAME" --prompt "Name> ")
export OMAKUB_USER_EMAIL=$(gum input --placeholder "Enter email address" --value "$DEFAULT_EMAIL" --prompt "Email> ")
