#!/bin/bash
# Unicode word flip (reverse word order)

word_flip_text() {
    local input="$1"
    local words=()
    local result=""
    
    # Split input into words and store in array
    IFS=' ' read -ra words <<< "$input"
    
    # Reverse the order of words
    for (( i=${#words[@]}-1; i>=0; i-- )); do
        if [[ -n "$result" ]]; then
            result+=" "
        fi
        result+="${words[$i]}"
    done
    
    echo "$result"
}

# Check if text is provided as argument
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 \"text to flip words\""
    echo "Example: $0 \"Hello World Everyone\""
    exit 1
fi

# Process the input text
input_text="$*"
flipped_text=$(word_flip_text "$input_text")

echo "Original: $input_text"
echo "Flipped:  $flipped_text"

# Copy to clipboard based on available tools
if command -v pbcopy >/dev/null 2>&1; then
    # macOS
    echo -n "$flipped_text" | pbcopy
    echo "✓ Copied to clipboard (macOS)"
elif command -v xclip >/dev/null 2>&1; then
    # Linux with xclip
    echo -n "$flipped_text" | xclip -selection clipboard
    echo "✓ Copied to clipboard (Linux - xclip)"
elif command -v xsel >/dev/null 2>&1; then
    # Linux with xsel
    echo -n "$flipped_text" | xsel --clipboard --input
    echo "✓ Copied to clipboard (Linux - xsel)"
elif command -v wl-copy >/dev/null 2>&1; then
    # Wayland
    echo -n "$flipped_text" | wl-copy
    echo "✓ Copied to clipboard (Wayland)"
else
    echo "⚠ Clipboard tool not found. Install xclip, xsel, or wl-clipboard for Linux, or use on macOS"
fi