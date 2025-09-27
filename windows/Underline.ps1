# Underline text using Unicode combining characters
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromRemainingArguments=$true)]
    [string[]]$Text
)

function UnderlineText {
    param([string]$InputText)
    
    $result = ""
    # Add combining underline (U+0332) to each character
    foreach ($char in $InputText.ToCharArray()) {
        if ($char -ne ' ') {
            # Add combining underline to non-space characters
            $result += $char.ToString() + [char]0x0332
        } else {
            $result += $char
        }
    }
    
    return $result
}

# Join all arguments into a single string
$InputText = $Text -join " "

if ([string]::IsNullOrWhiteSpace($InputText)) {
    Write-Host "Usage: .\Underline.ps1 'text to underline'"
    Write-Host "Example: .\Underline.ps1 'Hello World!'"
    exit 1
}

# Process the input text
$UnderlinedText = UnderlineText -InputText $InputText

Write-Host "Original:   $InputText"
Write-Host "Underlined: $UnderlinedText"

# Copy to clipboard
try {
    Set-Clipboard -Value $UnderlinedText
    Write-Host "✓ Copied to clipboard"
} catch {
    Write-Host "⚠ Failed to copy to clipboard: $($_.Exception.Message)"
}