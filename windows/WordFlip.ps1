# Unicode word flip (reverse word order)
param(
    [Parameter(Mandatory=$true, Position=0, ValueFromRemainingArguments=$true)]
    [string[]]$Text
)

function WordFlipText {
    param([string]$InputText)
    
    # Split input into words and reverse the order
    $words = $InputText -split '\s+'
    [Array]::Reverse($words)
    
    return $words -join " "
}

# Join all arguments into a single string
$InputText = $Text -join " "

if ([string]::IsNullOrWhiteSpace($InputText)) {
    Write-Host "Usage: .\WordFlip.ps1 'text to flip words'"
    Write-Host "Example: .\WordFlip.ps1 'Hello World Everyone'"
    exit 1
}

# Process the input text
$FlippedText = WordFlipText -InputText $InputText

Write-Host "Original: $InputText"
Write-Host "Flipped:  $FlippedText"

# Copy to clipboard
try {
    Set-Clipboard -Value $FlippedText
    Write-Host "✓ Copied to clipboard"
} catch {
    Write-Host "⚠ Failed to copy to clipboard: $($_.Exception.Message)"
}