# M7D Configuration PowerShell Profile 
# Prompt

# Icons
# Installation cmd: Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Import-Module -Name Terminal-Icons

# Load prompt config
function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'space.omp.json'
oh-my-posh init pwsh --config $PROMPT_CONFIG | Invoke-Expression

# Functions
function get-gitstatus { git status }
function get-gitlog{ git log }
function get-explorerhere{ explorer .}
function get-gitpush{ git push }

# Alias
Set-Alias ll ls
Set-Alias g git
Set-Alias -Name log -Value get-gitlog
Set-Alias -Name gs -Value get-gitstatus
Set-Alias -Name exh -Value get-explorerhere
Set-Alias -Name gpsh -Value get-gitpush

# Logo display logic
$asciiArt = @"
                                                                     
MMMMMMMM               MMMMMMMM77777777777777777777DDDDDDDDDDDDD        
M:::::::M             M:::::::M7::::::::::::::::::7D::::::::::::DDD     
M::::::::M           M::::::::M7::::::::::::::::::7D:::::::::::::::DD   
M:::::::::M         M:::::::::M777777777777:::::::7DDD:::::DDDDD:::::D  
M::::::::::M       M::::::::::M           7::::::7   D:::::D    D:::::D 
M:::::::::::M     M:::::::::::M          7::::::7    D:::::D     D:::::D
M:::::::M::::M   M::::M:::::::M         7::::::7     D:::::D     D:::::D
M::::::M M::::M M::::M M::::::M        7::::::7      D:::::D     D:::::D
M::::::M  M::::M::::M  M::::::M       7::::::7       D:::::D     D:::::D
M::::::M   M:::::::M   M::::::M      7::::::7        D:::::D     D:::::D
M::::::M    M:::::M    M::::::M     7::::::7         D:::::D     D:::::D
M::::::M     MMMMM     M::::::M    7::::::7          D:::::D    D:::::D 
M::::::M               M::::::M   7::::::7         DDD:::::DDDDD:::::D  
M::::::M               M::::::M  7::::::7          D:::::::::::::::DD   
M::::::M               M::::::M 7::::::7           D::::::::::::DDD     
MMMMMMMM               MMMMMMMM77777777            DDDDDDDDDDDDD        
"@

$asciiArt = $asciiArt.Trim()  # Remove leading and trailing whitespace

# Convert hexadecimal color to RGB
$red = 0x9b / 255
$green = 0x30 / 255
$blue = 0xff / 255

# Calculate ANSI escape code for the color
$colorCode = 16 + [math]::round($red * 5) * 36 + [math]::round($green * 5) * 6 + [math]::round($blue * 5)

$gradientArt = ""

for ($i = 0; $i -lt $asciiArt.Length; $i++) {
    $char = $asciiArt[$i]
    if ($char -eq ":") {
        $gradientArt += "`e[38;5;${colorCode}m$char"  # Neon Bright Purple for ":" characters
    } elseif ($i -le 30 -or $i -ge ($asciiArt.Length - 30) -or $i % ($asciiArt.IndexOf("`n") + 1) -le 30 -or $i % ($asciiArt.IndexOf("`n") + 1) -ge ($asciiArt.IndexOf("`n") + 1 - 30)) {
        $gradientArt += "`e[36m$char"  # Cyan for outer layer
    } else {
        $gradientArt += $char
    }
}

$gradientArt += "`e[0m"  # Reset color

Write-Host $gradientArt