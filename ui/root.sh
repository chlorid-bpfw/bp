#!/bin/bash

case $(gum choose "Artisan" "Extensions" "Managment" "Exit" --header="BP v$BLUEPRINT_TUI_VERSION") in
  Artisan)
    export window="artisan-root"
  ;;
  Extensions)
    export window="extensions-root"
  ;;
  Managment)
    export window ="managment-root"
esac
