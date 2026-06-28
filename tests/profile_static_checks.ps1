$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$Script = Get-Content -Raw -LiteralPath (Join-Path $Root "new-project.ps1")

function Assert-Contains {
    param(
        [Parameter(Mandatory)] [string]$Text,
        [Parameter(Mandatory)] [string]$Needle,
        [Parameter(Mandatory)] [string]$Message
    )

    if (-not $Text.Contains($Needle)) {
        throw $Message
    }
}

function Assert-NotContains {
    param(
        [Parameter(Mandatory)] [string]$Text,
        [Parameter(Mandatory)] [string]$Needle,
        [Parameter(Mandatory)] [string]$Message
    )

    if ($Text.Contains($Needle)) {
        throw $Message
    }
}

Assert-Contains $Script '[ValidateSet("base", "desktop", "web", "game")]' "Missing profile ValidateSet."
Assert-Contains $Script '$Profile = "base"' "Missing base profile default."

$TemplateNames = @(
    "agents/base.md",
    "agents/profiles/base.md",
    "agents/profiles/desktop.md",
    "agents/profiles/web.md",
    "agents/profiles/game.md",
    "game/frontend_main.ts",
    "game/backend_main.py",
    "game/scene.ts",
    "game/test_game_api.py",
    "game/playwright.config.ts",
    "game/game-smoke.spec.ts",
    "web/App.test.tsx",
    "web/test_setup.ts"
)

foreach ($TemplateName in $TemplateNames) {
    $Path = Join-Path (Join-Path $Root "templates") $TemplateName

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "Missing template: $TemplateName"
    }
}

$DesktopAgents = Get-Content -Raw -LiteralPath (Join-Path $Root "templates/agents/profiles/desktop.md")
$WebAgents = Get-Content -Raw -LiteralPath (Join-Path $Root "templates/agents/profiles/web.md")
$GameAgents = Get-Content -Raw -LiteralPath (Join-Path $Root "templates/agents/profiles/game.md")
$GameMain = Get-Content -Raw -LiteralPath (Join-Path $Root "templates/game/frontend_main.ts")
$GameScene = Get-Content -Raw -LiteralPath (Join-Path $Root "templates/game/scene.ts")
$GameStyle = Get-Content -Raw -LiteralPath (Join-Path $Root "templates/game/style.css")
$WebMain = Get-Content -Raw -LiteralPath (Join-Path $Root "templates/web/frontend_main.tsx")
$WebTest = Get-Content -Raw -LiteralPath (Join-Path $Root "templates/web/App.test.tsx")
$WebTestSetup = Get-Content -Raw -LiteralPath (Join-Path $Root "templates/web/test_setup.ts")
$GameSmokeTest = Get-Content -Raw -LiteralPath (Join-Path $Root "templates/game/game-smoke.spec.ts")
$GamePlaywrightConfig = Get-Content -Raw -LiteralPath (Join-Path $Root "templates/game/playwright.config.ts")

Assert-Contains $DesktopAgents "PySide6" "Desktop AGENTS snippet must mention PySide6."
Assert-Contains $WebAgents "backend/" "Web AGENTS snippet must mention backend/."
Assert-Contains $WebAgents "frontend/" "Web AGENTS snippet must mention frontend/."
Assert-Contains $GameAgents "Phaser" "Game AGENTS snippet must mention Phaser."
Assert-Contains $WebMain "react-dom/client" "Web frontend should still use React."
Assert-Contains $GameMain "new Phaser.Game" "Game frontend should create Phaser directly."
Assert-Contains $WebTest "@testing-library/react" "Web frontend test should use React Testing Library."
Assert-Contains $WebTest "Backend: demo ok" "Web frontend test should verify rendered backend status."
Assert-Contains $WebTestSetup "@testing-library/jest-dom/vitest" "Web test setup should install jest-dom matchers."
Assert-Contains $GameSmokeTest "canvas" "Game smoke test should verify Phaser creates a canvas."
Assert-Contains $GameSmokeTest "Backend: ready" "Game smoke test should verify rendered backend status."
Assert-Contains $GamePlaywrightConfig "webServer" "Game Playwright config should start Vite."

$PackageMarker = 'Write-TextFile -Path (Join-Path "frontend" "package.json") -Content @"'
$GamePackageStart = $Script.IndexOf($PackageMarker)
$GamePackageEnd = $Script.IndexOf('"@', $GamePackageStart)
$GamePackageBlock = $Script.Substring($GamePackageStart, $GamePackageEnd - $GamePackageStart)
$ViteMarker = 'Write-TextFile -Path (Join-Path "frontend" "vite.config.ts") -Content @'''
$GameViteStart = $Script.IndexOf($ViteMarker)
$GameViteEnd = $Script.IndexOf("'@", $GameViteStart)
$GameViteBlock = $Script.Substring($GameViteStart, $GameViteEnd - $GameViteStart)

foreach ($Needle in @("react", "React", "@vitejs/plugin-react", "react-dom", "jsx")) {
    Assert-NotContains $GameMain $Needle "Game frontend template should not contain $Needle."
    Assert-NotContains $GameScene $Needle "Game scene template should not contain $Needle."
    Assert-NotContains $GameStyle $Needle "Game CSS template should not contain $Needle."
    Assert-NotContains $GameAgents $Needle "Game AGENTS snippet should not contain $Needle."
    Assert-NotContains $GamePackageBlock $Needle "Game package generation should not contain $Needle."
    Assert-NotContains $GameViteBlock $Needle "Game Vite generation should not contain $Needle."
}

Assert-NotContains $Script '"game/App.tsx"' "Game profile should not generate a React App template."
Assert-Contains $Script '"test": "vitest run"' "Web profile should generate a Vitest test script."
Assert-Contains $Script '"test:e2e": "playwright test"' "Game profile should generate a Playwright test script."
Assert-Contains $Script 'Invoke-Checked $Npm run test' "Web profile check script should run frontend tests."
Assert-Contains $Script 'Invoke-Checked $Npm run test:e2e' "Game profile check script should run frontend tests."
Assert-Contains $Script 'Invoke-Checked $NpmCommand exec playwright install chromium' "Game profile should install Playwright Chromium during scaffold."
Assert-Contains $Script 'npx playwright install --with-deps chromium' "CI should install Playwright Chromium for game projects."

Write-Host "Profile static checks passed."
