#!/bin/bash
# Underline text using Unicode combining characters

underline_text() {
    local input="$1"
    local result=""
    local char
    
    # Add combining underline (U+0332) to each character
    for (( i=0; i<${#input}; i++ )); do
        char="${input:$i:1}"
        if [[ "$char" != " " ]]; then
            # Add combining underline to non-space characters
            result+="${char}̲"
        else
            result+="$char"
        fi
    done
    
    echo "$result"
}

# Check if text is provided as argument
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 \"text to underline\""
    echo "Example: $0 \"Hello World!\""
    exit 1
fi

# Process the input text
input_text="$*"
underlined_text=$(underline_text "$input_text")

echo "Original:   $input_text"
echo "Underlined: $underlined_text"

# Copy to clipboard based on available tools
if command -v pbcopy >/dev/null 2>&1; then
    # macOS
    echo -n "$underlined_text" | pbcopy
    echo "✓ Copied to clipboard (macOS)"
elif command -v xclip >/dev/null 2>&1; then
    # Linux with xclip
    echo -n "$underlined_text" | xclip -selection clipboard
    echo "✓ Copied to clipboard (Linux - xclip)"
elif command -v xsel >/dev/null 2>&1; then
    # Linux with xsel
    echo -n "$underlined_text" | xsel --clipboard --input
    echo "✓ Copied to clipboard (Linux - xsel)"
elif command -v wl-copy >/dev/null 2>&1; then
    # Wayland
    echo -n "$underlined_text" | wl-copy
    echo "✓ Copied to clipboard (Wayland)"
else
    echo "⚠ Clipboard tool not found. Install xclip, xsel, or wl-clipboard for Linux, or use on macOS"
fi