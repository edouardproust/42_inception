#!/bin/sh
# Install and remove themes

NEW_WP_THEME="twentytwentyone"
THEMES_LOG="[wordpress themes]"

echo "$THEMES_LOG Setup themes using WP-CLI"

# Install the compatible theme
if ! wp theme is-active $NEW_WP_THEME; then
	wp theme install $NEW_WP_THEME --activate
fi

# Clean other themes
if wp theme is-installed twentytwentyfive; then
	wp theme delete twentytwentythree
fi
if wp theme is-installed twentytwentyfive; then
	wp theme delete twentytwentyfour
fi
if wp theme is-installed twentytwentyfive; then
	wp theme delete twentytwentyfive
fi
