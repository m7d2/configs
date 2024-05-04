# Prompt
# To launch this profile on powershell start, you need to load it from main 
# Powershell config file
# Open powershell then: code $PROFILE
# REQUIRED: copy and paste this there . $env:USERPROFILE\.config\powershell\m7d.ps1
# IF Path doesn exists under your username then go to your username folder and create .config folder and create a subfolder called powershell and
# paste the profile in it
# save, exit, restart powershell
# REQUIRED: Install oh-my-posh using winget: winget install JanDeDobbeleer.OhMyPosh -s winget

# Icons
# REQUIRED Installation cmd: Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Import-Module -Name Terminal-Icons

# Set-PoshPrompt Paradox

# Load prompt config
function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'space.omp.json'
oh-my-posh init pwsh --config $PROMPT_CONFIG | Invoke-Expression


function get-gitstatus { git status }
function get-gitlog{ git log }
function get-explorerhere{ explorer .}
function get-gitpush{ git push }
# Alias
Set-Alias ll ls # list
Set-Alias g git # git
Set-Alias -Name log -Value get-gitlog # git log
Set-Alias -Name gs -Value get-gitstatus # git status
Set-Alias -Name exh -Value get-explorerhere # Open File explorer in the current directory
Set-Alias -Name gpsh -Value get-gitpush # Git push

