#!/bin/bash

# Define your menu options
opts=(
  "Go Back"
  "Upgrade Blueprint(latest release)"
  "Upgrade Blueprint(latest commit)"
  "Upgrade Pterodactyl"
  "Enter maintenance mode"
  "Exit maintenance mode"
)

# Show the menu
choice=$(gum choose "${opts[@]}" --header="Select an action" --height=6)

# Handle the choice
case "$choice" in
  "Go Back"|"")
    export window="managment-root"
    return
    ;;
  "Upgrade Blueprint(latest release)")
    gum log -l "info" "Upgrading Blueprint..."
    blueprint -upgrade
    ;;

  "Upgrade Blueprint(latest commit)")
    gum log -l "info" "Upgrading Blueprint"
    blueprint -upgrade remote
    ;;
    
  "Upgrade Pterodactyl")
    gum log -l "info" "Upgrading Pterodactyl..."
    cd /var/www/pterodactyl || { gum log -l "error" "Cannot access Pterodactyl folder"; return; }
    php artisan down
    curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv
    chmod -R 755 storage/* bootstrap/cache
    composer install --no-dev --optimize-autoloader
    php artisan migrate --seed --force
    blueprint -upgrade
    php artisan up
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
