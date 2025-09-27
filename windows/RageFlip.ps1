# Rage flip (upside-down text) using Unicode
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromRemainingArguments=$true)]
    [string[]]$Text
)

# Unicode mapping for upside-down characters
$FlipMap = @{
    'a' = 'ɐ'; 'b' = 'q'; 'c' = 'ɔ'; 'd' = 'p'; 'e' = 'ǝ'; 'f' = 'ɟ'; 'g' = 'ƃ'; 'h' = 'ɥ'
    'i' = 'ᴉ'; 'j' = 'ɾ'; 'k' = 'ʞ'; 'l' = 'l'; 'm' = 'ɯ'; 'n' = 'u'; 'o' = 'o'; 'p' = 'd'
    'q' = 'b'; 'r' = 'ɹ'; 's' = 's'; 't' = 'ʇ'; 'u' = 'n'; 'v' = 'ʌ'; 'w' = 'ʍ'; 'x' = 'x'
    'y' = 'ʎ'; 'z' = 'z'
    'A' = '∀'; 'B' = 'ᗺ'; 'C' = 'Ɔ'; 'D' = 'ᗡ'; 'E' = 'Ǝ'; 'F' = 'ᖴ'; 'G' = 'פ'; 'H' = 'H'
    'I' = 'I'; 'J' = 'ſ'; 'K' = 'ʞ'; 'L' = '˥'; 'M' = 'W'; 'N' = 'N'; 'O' = 'O'; 'P' = 'Ԁ'
    'Q' = 'Q'; 'R' = 'ᴿ'; 'S' = 'S'; 'T' = '┴'; 'U' = '∩'; 'V' = 'Λ'; 'W' = 'M'; 'X' = 'X'
    'Y' = '⅄'; 'Z' = 'Z'
    '0' = '0'; '1' = 'Ɩ'; '2' = 'ᄅ'; '3' = 'Ɛ'; '4' = 'ㄣ'; '5' = 'ϛ'; '6' = '9'; '7' = 'ㄥ'
    '8' = '8'; '9' = '6'
    '!' = '¡'; '?' = '¿'; '.' = '˙'; ',' = "'"; ';' = '؛'; ':' = ':'; '(' = ')'
    ')' = '('; '[' = '['; ']' = '['; '{' = '}'
    ' ' = ' '
}

function RageFlipText {
    param([string]$InputText)
    
    # Reverse the string and flip each character
    $reversed = $InputText.ToCharArray()
    [Array]::Reverse($reversed)
    
    $result = ""
    foreach ($char in $reversed) {
        $charStr = $char.ToString()
        if ($FlipMap.ContainsKey($charStr)) {
            $result += $FlipMap[$charStr]
        } else {
            $result += $charStr
        }
    }
    
    return $result
}

# Join all arguments into a single string
$InputText = $Text -join " "

if ([string]::IsNullOrWhiteSpace($InputText)) {
    Write-Host "Usage: .\RageFlip.ps1 'text to flip'"
    Write-Host "Example: .\RageFlip.ps1 'Hello World!'"
    exit 1
}

# Process the input text
$FlippedText = RageFlipText -InputText $InputText

Write-Host "Original: $InputText"
Write-Host "Flipped:  $FlippedText"

# Copy to clipboard
try {
    Set-Clipboard -Value $FlippedText
    Write-Host "✓ Copied to clipboard"
} catch {
    Write-Host "⚠ Failed to copy to clipboard: $($_.Exception.Message)"
}