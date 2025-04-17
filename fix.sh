#!/bin/bash

# Define the import line to add
IMPORT_LINE="import 'package:black_ants_app/config/app_constants.dart';"

# List of files to always add the import to
FILES=(
    "lib/main.dart"
    "lib/screens/advice_screen.dart"
    "lib/screens/save_screen.dart"
    "lib/screens/trade_screen.dart"
)

# Additional files to check for AppConstants usage
CHECK_FILES=(
    "lib/screens/invest_screen.dart"
    "lib/screens/splash_screen.dart"
)

# Function to add import line below Flutter imports
add_import() {
    local file="$1"
    if [ ! -f "$file" ]; then
        echo "Error: File $file not found!"
        return 1
    fi

    # Check if import already exists
    if grep -q "$IMPORT_LINE" "$file"; then
        echo "Import already exists in $file, skipping..."
        return 0
    fi

    # Find the last Flutter import line
    local last_flutter_import_line=$(grep -n "^import 'package:flutter/" "$file" | tail -n 1 | cut -d: -f1)

    if [ -z "$last_flutter_import_line" ]; then
        # No Flutter imports, add at the top
        echo "No Flutter imports found in $file, adding import at the top..."
        sed -i "1i $IMPORT_LINE" "$file"
    else
        # Add import after the last Flutter import
        echo "Adding import to $file after Flutter imports..."
        sed -i "$((last_flutter_import_line + 1))i $IMPORT_LINE" "$file"
    fi
}

# Function to check if file uses AppConstants
uses_app_constants() {
    local file="$1"
    grep -q "AppConstants" "$file"
}

# Add imports to specified files
for file in "${FILES[@]}"; do
    add_import "$file"
done

# Check additional files for AppConstants usage and add import if needed
for file in "${CHECK_FILES[@]}"; do
    if [ -f "$file" ] && uses_app_constants "$file"; then
        echo "$file uses AppConstants, adding import..."
        add_import "$file"
    else
        echo "$file does not use AppConstants or does not exist, skipping..."
    fi
done

# Modify trade_screen.dart to add mounted check in _fetchData catch block
TRADE_SCREEN="lib/screens/trade_screen.dart"
if [ -f "$TRADE_SCREEN" ]; then
    echo "Modifying $TRADE_SCREEN to add mounted check in _fetchData catch block..."

    # Check if the mounted check already exists
    if grep -A 2 "catch (e)" "$TRADE_SCREEN" | grep -q "if (mounted)"; then
        echo "Mounted check already exists in $TRADE_SCREEN, skipping modification..."
    else
        # Use awk to insert the mounted check around the ScaffoldMessenger
        awk '
        /catch \(e\) {/ {print; print "      if (mounted) {"; next}
        /ScaffoldMessenger\.of\(context\)\.showSnackBar\(/ {print "        " $0; next}
        /SnackBar\(content: Text\(.Failed to load market data/ {print "        " $0; next}
        /\), backgroundColor: Colors\.redAccent\)/ {print "        " $0; print "      }"; next}
        {print}
        ' "$TRADE_SCREEN" > tmp.dart && mv tmp.dart "$TRADE_SCREEN"
        echo "Mounted check added to $TRADE_SCREEN."
    fi
else
    echo "Error: $TRADE_SCREEN not found!"
fi

echo "Script completed."
