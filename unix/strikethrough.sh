#!/bin/bash
# Strikethrough text using Unicode combining characters

strikethrough_text() {
    local input="$1"
    local result=""
    local char
    
    # Add combining strikethrough (U+0336) to each character
    for (( i=0; i<${#input}; i++ )); do
        char="${input:$i:1}"
        if [[ "$char" != " " ]]; then
            # Add combining strikethrough to non-space characters
            result+="${char}̶"
        else
            result+="$char"
        fi
    done
    
    echo "$result"
}

# Check if text is provided as argument
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 \"text to strikethrough\""
    echo "Example: $0 \"Hello World!\""
    exit 1
fi

# Process the input text
input_text="$*"
strikethrough_result=$(strikethrough_text "$input_text")

echo "Original:      $input_text"
echo "Strikethrough: $strikethrough_result"

# Copy to clipboard based on available tools
if command -v pbcopy >/dev/null 2>&1; then
    # macOS
    echo -n "$strikethrough_result" | pbcopy
    echo "✓ Copied to clipboard (macOS)"
elif command -v xclip >/dev/null 2>&1; then
    # Linux with xclip
    echo -n "$strikethrough_result" | xclip -selection clipboard
    echo "✓ Copied to clipboard (Linux - xclip)"
elif command -v xsel >/dev/null 2>&1; then
    # Linux with xsel
    echo -n "$strikethrough_result" | xsel --clipboard --input
    echo "✓ Copied to clipboard (Linux - xsel)"
elif command -v wl-copy >/dev/null 2>&1; then
    # Wayland
    echo -n "$strikethrough_result" | wl-copy
    echo "✓ Copied to clipboard (Wayland)"
else
    echo "⚠ Clipboard tool not found. Install xclip, xsel, or wl-clipboard for Linux, or use on macOS"
fi