#!/bin/sh
# Create a wp menu with custom link.
# Adding a menu via WP-CLI requires the use of a classic theme like twentytwentyone (not compatible with recent Full-Site-Editing or Block themes)

WP_THEME="twentytwentyone"
MENU_LOG="[wordpress create_menu]"
MENU_SLUG="main-menu"

echo "$MENU_LOG Setup menu using WP-CLI"

# Install the compatible theme
if ! wp theme is-active $WP_THEME; then
	wp theme install $WP_THEME --activate
fi

# Create menu if it does not exists yet
if ! wp menu list --fields=slug 2>/dev/null | grep -q "$MENU_SLUG"; then
	wp menu create "$MENU_SLUG"
	wp menu location assign main-menu primary
fi

# Function to add a menu item if it does not exists yet
add_menu_item() {
	local item_title="$1"
	local item_url="$2"	
	if ! wp menu item list "$MENU_SLUG" --fields=title | grep -q "$item_title" 2>/dev/null; then
		wp menu item add-custom "$MENU_SLUG" "$item_title" "$item_url"
	fi
}

# Add menu items
add_menu_item "Home" "/"
add_menu_item "Portfolio" "https://portfolio.eproust.42.fr"
add_menu_item "Adminer" "/adminer"
