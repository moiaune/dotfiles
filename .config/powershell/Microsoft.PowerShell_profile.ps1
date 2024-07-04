# -----------------------------------------------------------------------------
#     - MODULES -
# -----------------------------------------------------------------------------

Import-Module -Name PSFzf
Import-Module -Name posh-git

if ($IsWindows) {
    $env:XDG_CONFIG_HOME = "$env:USERPROFILE/.config"
    if (-not(Test-Path -Path $env:XDG_CONFIG_HOME -PathType Container)) {
        New-Item -Path $env:XDG_CONFIG_HOME -ItemType Directory
    }
} else {
    $env:XDG_CONFIG_HOME = "$env:HOME/.config"
}

# -----------------------------------------------------------------------------
#     - PROMPT -
# -----------------------------------------------------------------------------

oh-my-posh init pwsh --config "$env:XDG_CONFIG_HOME/oh-my-posh/config.yml" | Invoke-Expression

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

function ListAllFilesAndFoldersSorted { param([string]$path = ".") Get-ChildItem -Path $path -Force | Sort-Object LastWriteTime }
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
