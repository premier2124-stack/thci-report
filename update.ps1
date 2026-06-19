# TKS 리포트 → GitHub 동기화 (머신 독립 — 노트북/사무실 어디서든 동작)
# OneDrive의 마감리뷰 + 장전프리핑 .md를 이 repo로 복사 → pull → commit → push
# 실행: 같은 폴더의 "동기화.bat" 더블클릭 (또는 우클릭 → PowerShell에서 실행)

$ErrorActionPreference = "Stop"
$repo = $PSScriptRoot                                   # 이 스크립트가 있는 폴더 = repo (경로 하드코딩 X)

# OneDrive 루트 자동 감지 (개인/회사 환경변수 둘 다 대비)
$od = $env:OneDrive; if (-not $od) { $od = $env:OneDriveConsumer }
$base = Join-Path $od "문서\시그널리포트\TKS데일리리포트"
if (-not (Test-Path $base)) {
    Write-Host "[!] 리포트 원본 폴더를 못 찾음:`n    $base`n    이 PC의 OneDrive 경로를 확인하세요." -ForegroundColor Yellow
    exit 1
}

Set-Location $repo
git pull --no-edit 2>&1 | Out-Host                      # 다른 PC에서 올린 것 먼저 받아오기(충돌 방지)

Copy-Item "$base\2026_시장정리\*.md"   "$repo\reports\"   -Force   # 마감 리뷰
Copy-Item "$base\2026_장전프리핑\*.md"  "$repo\premarket\" -Force   # 장전 프리핑

git add reports premarket
$msg = "reports update " + (Get-Date -Format "yyyy-MM-dd HH:mm")
git commit -m $msg
if ($LASTEXITCODE -eq 0) { git push; Write-Host "`n[OK] 동기화 완료 — 1~2분 후 사이트 반영." -ForegroundColor Green }
else { Write-Host "`n[i] 변경된 리포트 없음 (올릴 것 없음)." -ForegroundColor Cyan }
