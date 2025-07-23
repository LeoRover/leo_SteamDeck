#!/bin/bash

SCRIPT_PATH="$(dirname $(readlink -f "${BASH_SOURCE[0]}"))"
FILES=$(grep -rl \@\@REPO_PATH\@\@ $SCRIPT_PATH --exclude setup.sh)

#########################################
echo "Looking for installed containers."
CONTAINERS_NAMES=($(distrobox list | awk 'NR>1 {print $3}'))

if [ ${#CONTAINERS_NAMES[@]} -eq 0 ]; then
    echo "No containers found."
    exit 1
fi

############################################
echo "Choose a container to use:"
for i in "${!CONTAINERS_NAMES[@]}"; do
    index=$((i+1))
    echo "  $index) ${CONTAINERS_NAMES[i]}"
done

while true; do
    read -p "Your selection [1]: " choice

    if [[ -z "$choice" ]]; then
        choice=1
        break
    fi
    # Validate input
    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#CONTAINERS_NAMES[@]} )); then
        break
    else
        echo "Please select a valid option."
    fi
done

SELECTED_CONTAINER="${CONTAINERS_NAMES[$((choice-1))]}"
echo "Selected container: $SELECTED_CONTAINER"

############################################
for file in $FILES; do
    sed -i -e "s|@@REPO_PATH@@|$SCRIPT_PATH|g" $file
    sed -i -e "s|@@CONTAINER_NAME@@|$SELECTED_CONTAINER|g" $file
done

SCRIPTS=$(find . -name "*.sh" ! -name "*setup*")
for script in $SCRIPTS ${SCRIPT_PATH}/desktop_apps/*.desktop; do
    chmod +x $script
done

cp ${SCRIPT_PATH}/desktop_apps/*.desktop ~/Desktop

############################################
echo "Installing basic ros packages"
distrobox enter ${SELECTED_CONTAINER} -- ${SCRIPT_PATH}/setup-ros.sh
