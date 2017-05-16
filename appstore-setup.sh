#!/bin/sh

brew install mas

mas upgrade
for app in "Magnet" "DaisyDisk" "Brightness Slider" "iMovie" "Final Cut Pro" "Pages"
do
    echo "Searching appid for \"${app}\" on appstore"
    appstore_search_result=`mas search "${app}" | head -1`
    app_id=`echo "$appstore_search_result" | cut -f1 -d' '`
    echo "Installing ${app_id} (${app})"
done
