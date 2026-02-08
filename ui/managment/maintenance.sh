#!/bin/bash

# Define your menu options
opts=(
  "Go Back"
  "Enter maintenance mode"
  "Exit maintenance mode"
)

# Show the menu
choice=$(gum choose "${opts[@]}" --header="Select an action" --height=8)

# Handle the choice
case "$choice" in
  "Go Back"|"")
    export window="managment-root"
    return
    ;;
  "Enter maintenance mode")
    gum log -l "info" "Entering maintenance mode..."
    cd /var/www/pterodactyl || { gum log -l "error" "Cannot access Pterodactyl folder"; return; }
    php artisan down
    echo "cocaine" > /tmp/coke
    ;;
  "Exit maintenance mode")
    gum log -l "info" "Exiting maintenance mode..."
    cd /var/www/pterodactyl || { gum log -l "error" "Cannot access Pterodactyl folder"; return; }
    php artisan up
    ;;
esac

# Pause before going back
echo
gum log -l "info" "Press ENTER to continue"
read -r
export window="managment-root"
