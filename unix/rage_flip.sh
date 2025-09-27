#!/bin/bash
# Rage flip (upside-down text) using Unicode

# Unicode mapping for upside-down characters
declare -A flip_map=(
    ['a']='ɐ' ['b']='q' ['c']='ɔ' ['d']='p' ['e']='ǝ' ['f']='ɟ' ['g']='ƃ' ['h']='ɥ'
    ['i']='ᴉ' ['j']='ɾ' ['k']='ʞ' ['l']='l' ['m']='ɯ' ['n']='u' ['o']='o' ['p']='d'
    ['q']='b' ['r']='ɹ' ['s']='s' ['t']='ʇ' ['u']='n' ['v']='ʌ' ['w']='ʍ' ['x']='x'
    ['y']='ʎ' ['z']='z'
    ['A']='∀' ['B']='ᗺ' ['C']='Ɔ' ['D']='ᗡ' ['E']='Ǝ' ['F']='ᖴ' ['G']='פ' ['H']='H'
    ['I']='I' ['J']='ſ' ['K']='ʞ' ['L']='˥' ['M']='W' ['N']='N' ['O']='O' ['P']='Ԁ'
    ['Q']='Q' ['R']='ᴿ' ['S']='S' ['T']='┴' ['U']='∩' ['V']='Λ' ['W']='M' ['X']='X'
    ['Y']='⅄' ['Z']='Z'
    ['0']='0' ['1']='Ɩ' ['2']='ᄅ' ['3']='Ɛ' ['4']='ㄣ' ['5']='ϛ' ['6']='9' ['7']='ㄥ'
    ['8']='8' ['9']='6'
    ['!']='¡' ['?']='¿' ['.']='˙' [',']="'" [';']='؛' [':']=':', ['(']=')'
    [')']='(' ['[']='[' [']']='[' ['{']='}'
    [' ']=' '
)

rage_flip_text() {
    local input="$1"
    local result=""
    local char
    local flipped_char
    
    # Reverse the string and flip each character
    for (( i=${#input}-1; i>=0; i-- )); do
        char="${input:$i:1}"
        flipped_char="${flip_map[$char]}"
        if [[ -n "$flipped_char" ]]; then
            result+="$flipped_char"
        else
            result+="$char"
        fi
    done
    
    echo "$result"
}

# Check if text is provided as argument
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 \"text to flip\""
    echo "Example: $0 \"Hello World!\""
    exit 1
fi

# Process the input text
input_text="$*"
flipped_text=$(rage_flip_text "$input_text")

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