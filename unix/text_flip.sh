#!/bin/bash
# Unified text transformation script - all transformations in one

print_usage() {
    echo "Usage: $0 <transformation> \"text to transform\""
    echo ""
    echo "Available transformations:"
    echo "  rage        - Upside-down text (ɹɐƃǝ ɟlᴉd)"
    echo "  word        - Reverse word order"
    echo "  underline   - Add underlines (u̲n̲d̲e̲r̲l̲i̲n̲e̲)"
    echo "  sarcasm     - Alternating case (sArCaStIc)"
    echo "  strike      - Strikethrough text (s̶t̶r̶i̶k̶e̶)"
    echo "  all         - Show all transformations"
    echo ""
    echo "Examples:"
    echo "  $0 rage \"Hello World!\""
    echo "  $0 sarcasm \"This is so cool\""
    echo "  $0 all \"Hello World!\""
}

# Check if arguments are provided
if [[ $# -lt 2 ]]; then
    print_usage
    exit 1
fi

transformation="$1"
shift
input_text="$*"

# Get the directory where this script is located
script_dir="$(dirname "${BASH_SOURCE[0]}")"

copy_to_clipboard() {
    local text="$1"
    
    if command -v pbcopy >/dev/null 2>&1; then
        echo -n "$text" | pbcopy
        echo "✓ Copied to clipboard (macOS)"
    elif command -v xclip >/dev/null 2>&1; then
        echo -n "$text" | xclip -selection clipboard
        echo "✓ Copied to clipboard (Linux - xclip)"
    elif command -v xsel >/dev/null 2>&1; then
        echo -n "$text" | xsel --clipboard --input
        echo "✓ Copied to clipboard (Linux - xsel)"
    elif command -v wl-copy >/dev/null 2>&1; then
        echo -n "$text" | wl-copy
        echo "✓ Copied to clipboard (Wayland)"
    else
        echo "⚠ Clipboard tool not found. Install xclip, xsel, or wl-clipboard for Linux, or use on macOS"
    fi
}

run_transformation() {
    local transform="$1"
    local text="$2"
    local result=""
    local script_path=""
    
    case "$transform" in
        "rage")
            script_path="$script_dir/rage_flip.sh"
            ;;
        "word")
            script_path="$script_dir/word_flip.sh"
            ;;
        "underline")
            script_path="$script_dir/underline.sh"
            ;;
        "sarcasm")
            script_path="$script_dir/sarcasm.sh"
            ;;
        "strike")
            script_path="$script_dir/strikethrough.sh"
            ;;
        *)
            echo "Error: Unknown transformation '$transform'"
            return 1
            ;;
    esac
    
    if [[ -x "$script_path" ]]; then
        "$script_path" "$text" 2>/dev/null | grep -E "^(Original:|Flipped:|Underlined:|sArCaSm:|Strikethrough:)" || echo "Error running $script_path"
    else
        echo "Error: Script $script_path not found or not executable"
    fi
}

case "$transformation" in
    "rage"|"word"|"underline"|"sarcasm"|"strike")
        # Run the individual script directly
        case "$transformation" in
            "rage")
                "$script_dir/rage_flip.sh" "$input_text"
                ;;
            "word")
                "$script_dir/word_flip.sh" "$input_text"
                ;;
            "underline")
                "$script_dir/underline.sh" "$input_text"
                ;;
            "sarcasm")
                "$script_dir/sarcasm.sh" "$input_text"
                ;;
            "strike")
                "$script_dir/strikethrough.sh" "$input_text"
                ;;
        esac
        ;;
    "all")
        echo "Input: $input_text"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        
        echo "🔄 Rage Flip:"
        rage_result=$("$script_dir/rage_flip.sh" "$input_text" 2>/dev/null | grep "Flipped:" | sed 's/Flipped:  //')
        echo "   $rage_result"
        echo ""
        
        echo "🔄 Word Flip:"
        word_result=$("$script_dir/word_flip.sh" "$input_text" 2>/dev/null | grep "Flipped:" | sed 's/Flipped:  //')
        echo "   $word_result"
        echo ""
        
        echo "🔄 Underline:"
        underline_result=$("$script_dir/underline.sh" "$input_text" 2>/dev/null | grep "Underlined:" | sed 's/Underlined: //')
        echo "   $underline_result"
        echo ""
        
        echo "🔄 sArCaSm:"
        sarcasm_result=$("$script_dir/sarcasm.sh" "$input_text" 2>/dev/null | grep "sArCaSm:" | sed 's/sArCaSm:  //')
        echo "   $sarcasm_result"
        echo ""
        
        echo "🔄 Strikethrough:"
        strike_result=$("$script_dir/strikethrough.sh" "$input_text" 2>/dev/null | grep "Strikethrough:" | sed 's/Strikethrough: //')
        echo "   $strike_result"
        echo ""
        
        echo "Select which result to copy to clipboard:"
        echo "1) Rage Flip: $rage_result"
        echo "2) Word Flip: $word_result"
        echo "3) Underline: $underline_result"
        echo "4) sArCaSm: $sarcasm_result"
        echo "5) Strikethrough: $strike_result"
        echo "0) None"
        
        read -p "Enter choice (0-5): " choice
        
        case "$choice" in
            1) copy_to_clipboard "$rage_result" ;;
            2) copy_to_clipboard "$word_result" ;;
            3) copy_to_clipboard "$underline_result" ;;
            4) copy_to_clipboard "$sarcasm_result" ;;
            5) copy_to_clipboard "$strike_result" ;;
            0) echo "No text copied." ;;
            *) echo "Invalid choice. No text copied." ;;
        esac
        ;;
    *)
        echo "Error: Unknown transformation '$transformation'"
        print_usage
        exit 1
        ;;
esac