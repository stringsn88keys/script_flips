#!/bin/bash
# sArCaSm text (alternating case)

sarcasm_text() {
    local input="$1"
    local result=""
    local char
    local uppercase=true
    
    # Alternate case for each letter (not spaces or punctuation)
    for (( i=0; i<${#input}; i++ )); do
        char="${input:$i:1}"
        
        # Check if character is a letter
        if [[ "$char" =~ [a-zA-Z] ]]; then
            if $uppercase; then
                result+="${char^^}"  # Convert to uppercase
                uppercase=false
            else
                result+="${char,,}"  # Convert to lowercase
                uppercase=true
            fi
        else
            result+="$char"  # Keep non-letters as-is
        fi
    done
    
    echo "$result"
}

# Check if text is provided as argument
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 \"text to make sarcastic\""
    echo "Example: $0 \"This is so cool\""
    exit 1
fi

# Process the input text
input_text="$*"
sarcasm_result=$(sarcasm_text "$input_text")

echo "Original: $input_text"
echo "sArCaSm:  $sarcasm_result"

# Copy to clipboard based on available tools
if command -v pbcopy >/dev/null 2>&1; then
    # macOS
    echo -n "$sarcasm_result" | pbcopy
    echo "✓ Copied to clipboard (macOS)"
elif command -v xclip >/dev/null 2>&1; then
    # Linux with xclip
    echo -n "$sarcasm_result" | xclip -selection clipboard
    echo "✓ Copied to clipboard (Linux - xclip)"
elif command -v xsel >/dev/null 2>&1; then
    # Linux with xsel
    echo -n "$sarcasm_result" | xsel --clipboard --input
    echo "✓ Copied to clipboard (Linux - xsel)"
elif command -v wl-copy >/dev/null 2>&1; then
    # Wayland
    echo -n "$sarcasm_result" | wl-copy
    echo "✓ Copied to clipboard (Wayland)"
else
    echo "⚠ Clipboard tool not found. Install xclip, xsel, or wl-clipboard for Linux, or use on macOS"
fi