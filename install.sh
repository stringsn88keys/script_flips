#!/bin/bash
# Installation script for text_flips scripts

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${BLUE}➤${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

echo "🎨 script_flips Installation"
echo "============================="
echo ""

# Check if we're in the right directory
if [[ ! -f "unix/rage_flip.sh" ]]; then
    print_error "Installation script must be run from the script_flips directory"
    exit 1
fi

print_step "Making scripts executable..."
chmod +x unix/*.sh
print_success "Scripts are now executable"

# Check for clipboard tools
print_step "Checking for clipboard utilities..."

clipboard_found=false

if command -v pbcopy >/dev/null 2>&1; then
    print_success "Found pbcopy (macOS clipboard support)"
    clipboard_found=true
fi

if command -v xclip >/dev/null 2>&1; then
    print_success "Found xclip (Linux clipboard support)"
    clipboard_found=true
fi

if command -v xsel >/dev/null 2>&1; then
    print_success "Found xsel (Linux clipboard support)"
    clipboard_found=true
fi

if command -v wl-copy >/dev/null 2>&1; then
    print_success "Found wl-copy (Wayland clipboard support)"
    clipboard_found=true
fi

if ! $clipboard_found; then
    print_warning "No clipboard utility found"
    echo ""
    echo "To enable clipboard functionality on Linux, install one of:"
    echo "  • xclip:        sudo apt install xclip (Ubuntu/Debian) or sudo dnf install xclip (Fedora)"
    echo "  • xsel:         sudo apt install xsel (Ubuntu/Debian) or sudo dnf install xsel (Fedora)"
    echo "  • wl-clipboard: sudo apt install wl-clipboard (Ubuntu/Debian) - for Wayland"
    echo ""
fi

# Test scripts
print_step "Testing scripts..."

test_text="Hello World!"
failed_tests=0

for script in unix/*.sh; do
    script_name=$(basename "$script")
    if [[ "$script_name" == "text_flip.sh" ]]; then
        continue  # Skip the unified script for now
    fi
    
    if ./"$script" "$test_text" >/dev/null 2>&1; then
        print_success "$(basename "$script") - OK"
    else
        print_error "$(basename "$script") - FAILED"
        ((failed_tests++))
    fi
done

# Test unified script
if ./unix/text_flip.sh rage "$test_text" >/dev/null 2>&1; then
    print_success "text_flip.sh (unified) - OK"
else
    print_error "text_flip.sh (unified) - FAILED"
    ((failed_tests++))
fi

echo ""

if [[ $failed_tests -eq 0 ]]; then
    print_success "All tests passed! Installation complete."
    echo ""
    echo "🎯 Quick Start:"
    echo "  ./unix/text_flip.sh rage \"Hello World!\""
    echo "  ./unix/text_flip.sh all \"Your text here\""
    echo ""
    echo "📖 See README.md for detailed usage instructions"
else
    print_error "$failed_tests script(s) failed testing"
    exit 1
fi

# Optional: Add to PATH suggestion
echo ""
echo "💡 Optional: Add to your PATH for global access"
echo "   Add this line to your ~/.bashrc or ~/.zshrc:"
echo "   export PATH=\"\$PATH:$(pwd)/unix\""
echo ""
echo "   Then you can use: text_flip.sh rage \"Hello World!\" from anywhere"