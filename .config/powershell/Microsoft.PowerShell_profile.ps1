using namespace System.Management.Automation
using namespace System.Management.Automation.Language

# -----------------------------------------------------------------------------
#     - MODULES -
# -----------------------------------------------------------------------------

# Import-Module -Name Get-ChildItemColor
Import-Module -Name PSFzf
Import-Module -Name posh-git

# -----------------------------------------------------------------------------
#     - PROMPT -
# -----------------------------------------------------------------------------

oh-my-posh init pwsh --config "~/.oh-my-posh/themes/google.omp.yml" | Invoke-Expression

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
Set-PSReadLineKeyHandler -Chord "Alt+RightArrow" -Function ForwardWord
Set-PSReadLineKeyHandler -Chord "Alt+LeftArrow" -Function BackwardWord
Set-PSReadLineKeyHandler -Chord "Alt+LeftArrow" -Function BackwardWord
Set-PSReadLineKeyHandler -Chord "Ctrl+Backspace" -Function DeleteWord

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# --- Hide sensitive information from history
Set-PSReadLineOption -AddToHistoryHandler {
    param(
        [string]$line
    )
    $sensitive = "password|asplaintext|token|secret"
    return ($line -notmatch $sensitive)
}

# -----------------------------------------------------------------------------
#     - TERMINAL COLORS -
#     https://learn.microsoft.com/en-us/powershell/scripting/learn/shell/using-light-theme?view=powershell-7.3
# -----------------------------------------------------------------------------

# $ISETheme = @{
#     Command                = $PSStyle.Foreground.FromRGB(0x0000FF)
#     Comment                = $PSStyle.Foreground.FromRGB(0x006400)
#     ContinuationPrompt     = $PSStyle.Foreground.FromRGB(0x0000FF)
#     Default                = $PSStyle.Foreground.FromRGB(0x0000FF)
#     Emphasis               = $PSStyle.Foreground.FromRGB(0x287BF0)
#     Error                  = $PSStyle.Foreground.FromRGB(0xE50000)
#     InlinePrediction       = $PSStyle.Foreground.FromRGB(0x93A1A1)
#     Keyword                = $PSStyle.Foreground.FromRGB(0x00008b)
#     ListPrediction         = $PSStyle.Foreground.FromRGB(0x06DE00)
#     Member                 = $PSStyle.Foreground.FromRGB(0x000000)
#     Number                 = $PSStyle.Foreground.FromRGB(0x800080)
#     Operator               = $PSStyle.Foreground.FromRGB(0x757575)
#     Parameter              = $PSStyle.Foreground.FromRGB(0x000080)
#     String                 = $PSStyle.Foreground.FromRGB(0x8b0000)
#     Type                   = $PSStyle.Foreground.FromRGB(0x008080)
#     Variable               = $PSStyle.Foreground.FromRGB(0xff4500)
#     ListPredictionSelected = $PSStyle.Background.FromRGB(0x93A1A1)
#     Selection              = $PSStyle.Background.FromRGB(0x00BFFF)
# }
# Set-PSReadLineOption -Colors $ISETheme

# # Improve light theme in terminal
# $PSStyle.Formatting.FormatAccent       = "`e[32m"
# $PSStyle.Formatting.TableHeader        = "`e[32m"
# $PSStyle.Formatting.ErrorAccent        = "`e[36m"
# $PSStyle.Formatting.Error              = "`e[31m"
# $PSStyle.Formatting.Warning            = "`e[33m"
# $PSStyle.Formatting.Verbose            = "`e[33m"
# $PSStyle.Formatting.Debug              = "`e[33m"
# $PSStyle.Progress.Style                = "`e[33m"
# $PSStyle.FileInfo.Directory            = $PSStyle.Background.FromRgb(0x2f6aff) + $PSStyle.Foreground.BrightWhite
# $PSStyle.FileInfo.SymbolicLink         = "`e[36m"
# $PSStyle.FileInfo.Executable           = "`e[95m"
# $PSStyle.FileInfo.Extension['.ps1']    = "`e[36m"
# $PSStyle.FileInfo.Extension['.ps1xml'] = "`e[36m"
# $PSStyle.FileInfo.Extension['.psd1']   = "`e[36m"
# $PSStyle.FileInfo.Extension['.psm1']   = "`e[36m"

Set-PSReadLineOption -Colors @{ Member = "`e[95m"; Number = "`e[95m" }
Set-PSReadLineOption -Colors @{
    Member    = "`e[95m"
    Parameter = "`e[97m"
    Number    = "`e[97m"
}


# -----------------------------------------------------------------------------
#     - ALIASES -
# -----------------------------------------------------------------------------
function ListFilesAndFolders { param([string]$path = ".") Get-ChildItem -Path $path }
Set-Alias -Name ll -Value ListFilesAndFolders

function ListAllFilesAndFolders { param([string]$path = ".") Get-ChildItem -Path $path -Force }
Set-Alias -Name la -Value ListAllFilesAndFolders

function ListAllFilesAndFoldersSorted { param([string]$path = ".") Get-ChildItem -Path $path -Force | Sort-Object LastWriteTime }
Set-Alias -Name lss -Value ListAllFilesAndFoldersSorted

function GitCommitAlias { git commit -m $args[0] }
Set-Alias -Name gcmm -Value GitCommitAlias

function GitStatusAll { git status -uall }
Set-Alias -Name gsa -Value GitStatusAll

function GitCommitPatch { git commit -p }
Set-Alias -Name gcp -Value GitCommitPatch

function GitAddPatch { git add -p $args }
Set-Alias -Name gap -Value GitAddPatch

Set-Alias -Name vim -Value nvim
