# sArCaSm text (alternating case)
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromRemainingArguments=$true)]
    [string[]]$Text
)

function SarcasmText {
    param([string]$InputText)
    
    $result = ""
    $uppercase = $true
    
    # Alternate case for each letter (not spaces or punctuation)
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
            $result += $char  # Keep non-letters as-is
        }
    }
    
    return $result
}

# Join all arguments into a single string
$InputText = $Text -join " "

if ([string]::IsNullOrWhiteSpace($InputText)) {
    Write-Host "Usage: .\Sarcasm.ps1 'text to make sarcastic'"
    Write-Host "Example: .\Sarcasm.ps1 'This is so cool'"
    exit 1
}

# Process the input text
$SarcasmResult = SarcasmText -InputText $InputText

Write-Host "Original: $InputText"
Write-Host "sArCaSm:  $SarcasmResult"

# Copy to clipboard
try {
    Set-Clipboard -Value $SarcasmResult
    Write-Host "✓ Copied to clipboard"
} catch {
    Write-Host "⚠ Failed to copy to clipboard: $($_.Exception.Message)"
}