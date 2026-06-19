# TKS 리포트 → GitHub 동기화
# OneDrive 리포트 폴더의 .md를 reports/로 복사한 뒤 commit + push 한다.
# 사용법: 이 파일 우클릭 → "PowerShell에서 실행" (또는 터미널에서 ./update.ps1)

$src  = "C:\Users\kimth\OneDrive\문서\시그널리포트\TKS데일리리포트\2026_시장정리"
$repo = "C:\Users\kimth\tks-reports"

Copy-Item "$src\*.md" "$repo\reports\" -Force
Set-Location $repo
git add reports
$msg = "reports update " + (Get-Date -Format "yyyy-MM-dd HH:mm")
git commit -m $msg
if ($?) { git push; Write-Host "`n[OK] 동기화 완료 — 1~2분 후 사이트에 반영됩니다." }
else    { Write-Host "`n[i] 변경된 리포트가 없습니다 (커밋할 것 없음)." }
