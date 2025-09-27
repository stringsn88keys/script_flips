# script_flips
Collection of macOS, Windows, and Linux scripts to decorate text with Unicode transformations that automatically copy results to the clipboard.

## Features

Transform your text with these fun Unicode effects:
- **Rage Flip** - Turn text upside-down (ɹǝʌǝɹsǝp)
- **Word Flip** - Reverse word order 
- **Underline** - Add Unicode underlines (u̲n̲d̲e̲r̲l̲i̲n̲e̲)
- **sArCaSm** - Alternating case (sArCaStIc)
- **Strikethrough** - Add Unicode strikethrough (s̶t̶r̶i̶k̶e̶t̶h̶r̶o̶u̶g̶h̶)

All scripts automatically copy the transformed text to your system clipboard!

## Installation

### Linux/macOS (Unix-like systems)

1. Clone the repository:
```bash
git clone https://github.com/stringsn88keys/script_flips.git
cd script_flips
```

2. Make scripts executable:
```bash
chmod +x unix/*.sh
```

3. For clipboard functionality on Linux, install one of:
```bash
# Ubuntu/Debian
sudo apt install xclip
# or
sudo apt install xsel
# or for Wayland
sudo apt install wl-clipboard

# Fedora/RHEL
sudo dnf install xclip
# or
sudo dnf install xsel

# Arch Linux
sudo pacman -S xclip
# or
sudo pacman -S xsel
```

### Windows (PowerShell)

1. Clone the repository or download the PowerShell scripts from the `windows/` folder
2. Scripts are ready to use (PowerShell 5.0+ required)

## Usage

### Linux/macOS Scripts

```bash
# Rage flip (upside-down text)
./unix/rage_flip.sh "Hello World!"
# Output: ¡plɹoM ollǝH

# Word flip (reverse word order)
./unix/word_flip.sh "Hello World Everyone"
# Output: Everyone World Hello

# Underline text
./unix/underline.sh "Hello World!"
# Output: H̲e̲l̲l̲o̲ W̲o̲r̲l̲d̲!̲

# sArCaSm text
./unix/sarcasm.sh "This is so cool"
# Output: ThIs Is So CoOl

# Strikethrough text
./unix/strikethrough.sh "Hello World!"
# Output: H̶e̶l̶l̶o̶ W̶o̶r̶l̶d̶!̶
```

### Windows PowerShell Scripts

```powershell
# Rage flip (upside-down text)
.\windows\RageFlip.ps1 "Hello World!"
# Output: ¡plɹoM ollǝH

# Word flip (reverse word order)
.\windows\WordFlip.ps1 "Hello World Everyone"
# Output: Everyone World Hello

# Underline text
.\windows\Underline.ps1 "Hello World!"
# Output: H̲e̲l̲l̲o̲ W̲o̲r̲l̲d̲!̲

# sArCaSm text
.\windows\Sarcasm.ps1 "This is so cool"
# Output: ThIs Is So CoOl

# Strikethrough text
.\windows\Strikethrough.ps1 "Hello World!"
# Output: H̶e̶l̶l̶o̶ W̶o̶r̶l̶d̶!̶
```

## Examples

Transform "Hello World!" with different effects:

| Effect | Result |
|--------|--------|
| Original | Hello World! |
| Rage Flip | ¡plɹoM ollǝH |
| Word Flip | World! Hello |
| Underline | H̲e̲l̲l̲o̲ W̲o̲r̲l̲d̲!̲ |
| sArCaSm | HeLlO WoRlD! |
| Strikethrough | H̶e̶l̶l̶o̶ W̶o̶r̶l̶d̶!̶ |

## Directory Structure

```
script_flips/
├── unix/           # Linux/macOS bash scripts
│   ├── rage_flip.sh
│   ├── word_flip.sh
│   ├── underline.sh
│   ├── sarcasm.sh
│   └── strikethrough.sh
├── windows/        # Windows PowerShell scripts
│   ├── RageFlip.ps1
│   ├── WordFlip.ps1
│   ├── Underline.ps1
│   ├── Sarcasm.ps1
│   └── Strikethrough.ps1
└── README.md
```

## Technical Details

- **Unicode Support**: Uses Unicode combining characters and special Unicode symbols
- **Clipboard Integration**: Automatically copies results to system clipboard
- **Cross-Platform**: Native implementations for Linux/macOS (bash) and Windows (PowerShell)
- **No Dependencies**: Works with standard system tools (except clipboard utilities on Linux)

## Supported Platforms

- **Linux**: Any distribution with bash (clipboard requires xclip, xsel, or wl-clipboard)
- **macOS**: Built-in clipboard support via pbcopy
- **Windows**: PowerShell 5.0+ with built-in clipboard support

## License

MIT License - see [LICENSE](LICENSE) file for details.
