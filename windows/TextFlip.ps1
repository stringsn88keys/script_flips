# Unified text transformation script for PowerShell - all transformations in one
param(
    [Parameter(Mandatory=$false, Position=0)]
    [string]$Transformation,
    
    [Parameter(Mandatory=$false, Position=1, ValueFromRemainingArguments=$true)]
    [string[]]$Text
)

function Show-Usage {
    Write-Host "Usage: .\TextFlip.ps1 <transformation> 'text to transform'"
    Write-Host ""
    Write-Host "Available transformations:"
    Write-Host "  rage        - Upside-down text (ɹɐƃǝ ɟlᴉd)"
    Write-Host "  word        - Reverse word order"
    Write-Host "  underline   - Add underlines (u̲n̲d̲e̲r̲l̲i̲n̲e̲)"
    Write-Host "  sarcasm     - Alternating case (sArCaStIc)"
    Write-Host "  strike      - Strikethrough text (s̶t̶r̶i̶k̶e̶)"
    Write-Host "  all         - Show all transformations"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\TextFlip.ps1 rage 'Hello World!'"
    Write-Host "  .\TextFlip.ps1 sarcasm 'This is so cool'"
    Write-Host "  .\TextFlip.ps1 all 'Hello World!'"
}

# Unicode mapping for rage flip
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

function Invoke-RageFlip($InputText) {
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

function Invoke-WordFlip($InputText) {
    $words = $InputText -split '\s+'
    [Array]::Reverse($words)
    return $words -join " "
}

function Invoke-Underline($InputText) {
    $result = ""
    foreach ($char in $InputText.ToCharArray()) {
        if ($char -ne ' ') {
            $result += $char.ToString() + [char]0x0332
        } else {
            $result += $char
        }
    }
    return $result
}

function Invoke-Sarcasm($InputText) {
    $result = ""
    $uppercase = $true
    
    foreach ($char in $InputText.ToCharArray()) {
        if ($char -match '[a-zA-Z]') {
            if ($uppercase) {
                $result += $char.ToString().ToUpper()
                $uppercase = $false
            } else {
                $result += $char.ToString().ToLower()
                $uppercase = $true
            }
        } else {
            $result += $char
        }
    }
    return $result
}

function Invoke-Strikethrough($InputText) {
    $result = ""
    foreach ($char in $InputText.ToCharArray()) {
        if ($char -ne ' ') {
            $result += $char.ToString() + [char]0x0336
        } else {
            $result += $char
        }
    }
    return $result
}

function Copy-ToClipboardSafe($text) {
    try {
        Set-Clipboard -Value $text
        Write-Host "✓ Copied to clipboard"
    } catch {
        Write-Host "⚠ Failed to copy to clipboard: $($_.Exception.Message)"
    }
}

# Check if parameters are provided
if ([string]::IsNullOrWhiteSpace($Transformation) -or ($Text.Count -eq 0 -and $Transformation -ne "help")) {
    Show-Usage
    exit 1
}

# Join all text arguments into a single string
$InputText = $Text -join " "

switch ($Transformation.ToLower()) {
    "rage" {
        $result = Invoke-RageFlip -InputText $InputText
        Write-Host "Original: $InputText"
        Write-Host "Flipped:  $result"
        Copy-ToClipboardSafe $result
    }
    "word" {
        $result = Invoke-WordFlip -InputText $InputText
        Write-Host "Original: $InputText"
        Write-Host "Flipped:  $result"
        Copy-ToClipboardSafe $result
    }
    "underline" {
        $result = Invoke-Underline -InputText $InputText
        Write-Host "Original:   $InputText"
        Write-Host "Underlined: $result"
        Copy-ToClipboardSafe $result
    }
    "sarcasm" {
        $result = Invoke-Sarcasm -InputText $InputText
        Write-Host "Original: $InputText"
        Write-Host "sArCaSm:  $result"
        Copy-ToClipboardSafe $result
    }
    "strike" {
        $result = Invoke-Strikethrough -InputText $InputText
        Write-Host "Original:      $InputText"
        Write-Host "Strikethrough: $result"
        Copy-ToClipboardSafe $result
    }
    "all" {
        Write-Host "Input: $InputText"
        Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        Write-Host ""
        
        $rageResult = Invoke-RageFlip -InputText $InputText
        $wordResult = Invoke-WordFlip -InputText $InputText
        $underlineResult = Invoke-Underline -InputText $InputText
        $sarcasmResult = Invoke-Sarcasm -InputText $InputText
        $strikeResult = Invoke-Strikethrough -InputText $InputText
        
        Write-Host "🔄 Rage Flip:"
        Write-Host "   $rageResult"
        Write-Host ""
        
        Write-Host "🔄 Word Flip:"
        Write-Host "   $wordResult"
        Write-Host ""
        
        Write-Host "🔄 Underline:"
        Write-Host "   $underlineResult"
        Write-Host ""
        
        Write-Host "🔄 sArCaSm:"
        Write-Host "   $sarcasmResult"
        Write-Host ""
        
        Write-Host "🔄 Strikethrough:"
        Write-Host "   $strikeResult"
        Write-Host ""
        
        Write-Host "Select which result to copy to clipboard:"
        Write-Host "1) Rage Flip: $rageResult"
        Write-Host "2) Word Flip: $wordResult"
        Write-Host "3) Underline: $underlineResult"
        Write-Host "4) sArCaSm: $sarcasmResult"
        Write-Host "5) Strikethrough: $strikeResult"
        Write-Host "0) None"
        
        $choice = Read-Host "Enter choice (0-5)"
        
        switch ($choice) {
            "1" { Copy-ToClipboardSafe $rageResult }
            "2" { Copy-ToClipboardSafe $wordResult }
            "3" { Copy-ToClipboardSafe $underlineResult }
            "4" { Copy-ToClipboardSafe $sarcasmResult }
            "5" { Copy-ToClipboardSafe $strikeResult }
            "0" { Write-Host "No text copied." }
            default { Write-Host "Invalid choice. No text copied." }
        }
    }
    default {
        Write-Host "Error: Unknown transformation '$Transformation'"
        Show-Usage
        exit 1
    }
}