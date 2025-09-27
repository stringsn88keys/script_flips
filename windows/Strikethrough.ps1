# Strikethrough text using Unicode combining characters
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromRemainingArguments=$true)]
    [string[]]$Text
)

function StrikethroughText {
    param([string]$InputText)
    
    $result = ""
    # Add combining strikethrough (U+0336) to each character
    foreach ($char in $InputText.ToCharArray()) {
        if ($char -ne ' ') {
            # Add combining strikethrough to non-space characters
            $result += $char.ToString() + [char]0x0336
        } else {
            $result += $char
        }
    }
    
    return $result
}

# Join all arguments into a single string
$InputText = $Text -join " "

if ([string]::IsNullOrWhiteSpace($InputText)) {
    Write-Host "Usage: .\Strikethrough.ps1 'text to strikethrough'"
    Write-Host "Example: .\Strikethrough.ps1 'Hello World!'"
    exit 1
}

# Process the input text
$StrikethroughResult = StrikethroughText -InputText $InputText

Write-Host "Original:      $InputText"
Write-Host "Strikethrough: $StrikethroughResult"

# Copy to clipboard
try {
    Set-Clipboard -Value $StrikethroughResult
    Write-Host "✓ Copied to clipboard"
} catch {
    Write-Host "⚠ Failed to copy to clipboard: $($_.Exception.Message)"
}