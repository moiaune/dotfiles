using namespace System.Management.Automation
using namespace System.Management.Automation.Language

# -----------------------------------------------------------------------------
#     - MODULES -
# -----------------------------------------------------------------------------

Import-Module -Name Get-ChildItemColor
Import-Module -Name PSFzf
Import-Module -Name posh-git

# -----------------------------------------------------------------------------
#     - PROMPT -
# -----------------------------------------------------------------------------

oh-my-posh init pwsh --config "~/code/github.com/madsaune/milbo-omp-theme/milbo.omp.yml" | Invoke-Expression

# -----------------------------------------------------------------------------
#     - ENVIRONMENT VARIABLES -
# -----------------------------------------------------------------------------

$env:PATH += ":$env:HOME/go/bin"
$env:EDITOR = "nvim"
$env:VISUAL = "code"

# -----------------------------------------------------------------------------
#     - CUSTOM FUNCTIONS -
# -----------------------------------------------------------------------------

function New-Note {
    param(
        [Parameter()]
        [string] $Name = "{0}.md" -f (New-Guid)
    )

    $path = Join-Path $env:HOME "notes" $Name

    "$env:EDITOR $path" | Invoke-Expression
}

function Open-Note {
    param(
        [Parameter()]
        [string] $Name = ""
    )

    $notesPath = Join-Path $env:HOME "notes"
    $path = Join-Path $notesPath $Name

    if (Test-Path $path) {
        "$env:EDITOR $path" | Invoke-Expression
    } else {
        "$env:EDITOR $notesPath" | Invoke-Expression
    }
}

# -----------------------------------------------------------------------------
#     - PSREADLINE CONFIGURATIONS -
# -----------------------------------------------------------------------------

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Chord "Ctrl+f" -Function ForwardWord

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

Set-PSReadLineKeyHandler -Key '"', "'" `
    -BriefDescription SmartInsertQuote `
    -LongDescription "Insert paired quotes if not already on a quote" `
    -ScriptBlock {
    param($key, $arg)

    $quote = $key.KeyChar

    $selectionStart = $null
    $selectionLength = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    # If text is selected, just quote it without any smarts
    if ($selectionStart -ne -1) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $quote + $line.SubString($selectionStart, $selectionLength) + $quote)
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
        return
    }

    $ast = $null
    $tokens = $null
    $parseErrors = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$parseErrors, [ref]$null)

    function FindToken {
        param($tokens, $cursor)

        foreach ($token in $tokens) {
            if ($cursor -lt $token.Extent.StartOffset) { continue }
            if ($cursor -lt $token.Extent.EndOffset) {
                $result = $token
                $token = $token -as [StringExpandableToken]
                if ($token) {
                    $nested = FindToken $token.NestedTokens $cursor
                    if ($nested) { $result = $nested }
                }

                return $result
            }
        }
        return $null
    }

    $token = FindToken $tokens $cursor

    # If we're on or inside a **quoted** string token (so not generic), we need to be smarter
    if ($token -is [StringToken] -and $token.Kind -ne [TokenKind]::Generic) {
        # If we're at the start of the string, assume we're inserting a new string
        if ($token.Extent.StartOffset -eq $cursor) {
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote ")
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
            return
        }

        # If we're at the end of the string, move over the closing quote if present.
        if ($token.Extent.EndOffset -eq ($cursor + 1) -and $line[$cursor] -eq $quote) {
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
            return
        }
    }

    if ($null -eq $token -or
        $token.Kind -eq [TokenKind]::RParen -or $token.Kind -eq [TokenKind]::RCurly -or $token.Kind -eq [TokenKind]::RBracket) {
        if ($line[0..$cursor].Where{ $_ -eq $quote }.Count % 2 -eq 1) {
            # Odd number of quotes before the cursor, insert a single quote
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
        } else {
            # Insert matching quotes, move cursor to be in between the quotes
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote")
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
        }
        return
    }

    # If cursor is at the start of a token, enclose it in quotes.
    if ($token.Extent.StartOffset -eq $cursor) {
        if ($token.Kind -eq [TokenKind]::Generic -or $token.Kind -eq [TokenKind]::Identifier -or
            $token.Kind -eq [TokenKind]::Variable -or $token.TokenFlags.hasFlag([TokenFlags]::Keyword)) {
            $end = $token.Extent.EndOffset
            $len = $end - $cursor
            [Microsoft.PowerShell.PSConsoleReadLine]::Replace($cursor, $len, $quote + $line.SubString($cursor, $len) + $quote)
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($end + 2)
            return
        }
    }

    # We failed to be smart, so just insert a single quote
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
}

# --- Hide sensitive information from history
Set-PSReadLineOption -AddToHistoryHandler {
    param(
        [string]$line
    )
    $sensitive = "password|asplaintext|token|secret"
    return ($line -notmatch $sensitive)
}

# --- ALIASES
function ListFilesAndFolders { Get-ChildItem -Path . }
Set-Alias -Name ll -Value ListFilesAndFolders

function ListAllFilesAndFolders { Get-ChildItem -Path . -Force }
Set-Alias -Name la -Value ListAllFilesAndFolders

function GitCommitAlias { git commit -m $args[0] }
Set-Alias -Name gcmm -Value GitCommitAlias

function GitStatusAll { git status -uall }
Set-Alias -Name gsa -Value GitStatusAll

function TerraformCheckFormatting { terraform fmt -check -recursive }
Set-Alias -Name tcfmt -Value TerraformCheckFormatting

function TerraformFormatAll { terraform fmt -recursive }
Set-Alias -Name tfmt -Value TerraformFormatAll
