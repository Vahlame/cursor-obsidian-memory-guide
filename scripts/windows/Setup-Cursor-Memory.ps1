param(
    [Parameter(Mandatory = $true)]
    [string]$RepoUrl,
    [string]$VaultPath = "$HOME\Documents\cursor-memory-vault",
    [string]$Branch = "main",
    [string]$CursorMcpPath = "$HOME\.cursor\mcp.json",
    [int]$Port = 3001
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Ensure-Directory {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "Git no disponible." }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw "Node no disponible." }
if (-not (Get-Command npm -ErrorAction SilentlyContinue)) { throw "npm no disponible." }

if (-not (Test-Path -LiteralPath $VaultPath)) {
    git clone $RepoUrl $VaultPath
} else {
    if (-not (Test-Path -LiteralPath (Join-Path $VaultPath ".git"))) {
        throw "La ruta '$VaultPath' existe pero no es un repo git."
    }
    git -C $VaultPath fetch origin
    git -C $VaultPath checkout $Branch
    git -C $VaultPath pull --rebase origin $Branch
}

Ensure-Directory -Path (Join-Path $VaultPath "PROJECTS")
Ensure-Directory -Path (Join-Path $VaultPath "SNIPPETS")
Ensure-Directory -Path (Join-Path $VaultPath "scripts\windows")

$memory = Join-Path $VaultPath "MEMORY.md"
$session = Join-Path $VaultPath "SESSION_LOG.md"
$template = Join-Path $VaultPath "PROJECTS\TEMPLATE.md"

if (-not (Test-Path -LiteralPath $memory)) { Set-Content -Path $memory -Value "# MEMORY" -Encoding UTF8 }
if (-not (Test-Path -LiteralPath $session)) { Set-Content -Path $session -Value "# SESSION LOG" -Encoding UTF8 }
if (-not (Test-Path -LiteralPath $template)) { Set-Content -Path $template -Value "# <proyecto>" -Encoding UTF8 }

$sourceDir = $PSScriptRoot
$targets = @(
    "Setup-Cursor-Memory.ps1",
    "Sync-Memory.ps1",
    "Enable-AutoSync.ps1",
    "Ensure-ObsidianMCP.ps1",
    "Enable-MCP-Watchdog.ps1",
    "Doctor.ps1"
)
foreach ($file in $targets) {
    Copy-Item -Path (Join-Path $sourceDir $file) -Destination (Join-Path $VaultPath "scripts\windows\$file") -Force
}

Ensure-Directory -Path (Split-Path -Path $CursorMcpPath -Parent)
$mcpConfig = [pscustomobject]@{
    mcpServers = [pscustomobject]@{
        "obsidian-memory" = [pscustomobject]@{
            command = "npx"
            args = @("-y", "mcp-remote", "http://127.0.0.1:$Port/sse")
        }
    }
}
Set-Content -Path $CursorMcpPath -Value ($mcpConfig | ConvertTo-Json -Depth 20) -Encoding UTF8

powershell -ExecutionPolicy Bypass -File (Join-Path $VaultPath "scripts\windows\Enable-MCP-Watchdog.ps1") -VaultPath $VaultPath -Port $Port
powershell -ExecutionPolicy Bypass -File (Join-Path $VaultPath "scripts\windows\Enable-AutoSync.ps1") -VaultPath $VaultPath -EveryMinutes 10
powershell -ExecutionPolicy Bypass -File (Join-Path $VaultPath "scripts\windows\Doctor.ps1") -VaultPath $VaultPath -CursorMcpPath $CursorMcpPath -Port $Port

Write-Host ""
Write-Host "Setup completado."
Write-Host "1) Reinicia Cursor"
Write-Host "2) Pega PROMPT_ULTRA_COMPLETO.md en User Rules"
