# Script tự động upload code lên GitHub
Write-Host "=== TỰ ĐỘNG UPLOAD CODE LÊN GITHUB ===" -ForegroundColor Cyan

# Kiểm tra xem Git đã được cài đặt chưa
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Lỗi: Máy tính chưa cài đặt Git! Vui lòng tải và cài đặt Git hoặc dùng GitHub Desktop." -ForegroundColor Red
    Write-Host "Link tải Git: https://git-scm.com/downloads" -ForegroundColor Yellow
    Pause
    Exit
}

# Nhập URL repo GitHub
$repoUrl = Read-Host "Nhập link repository GitHub của bạn (ví dụ: https://github.com/username/repo.git)"
if ([string]::IsNullOrWhitespace($repoUrl)) {
    Write-Host "Lỗi: Link GitHub không được để trống!" -ForegroundColor Red
    Pause
    Exit
}

# Khởi tạo git nếu chưa có
if (!(Test-Path .git)) {
    git init
    git branch -M main
}

# Thêm remote origin
git remote remove origin 2>$null
git remote add origin $repoUrl

# Add và Commit (sẽ tự động bỏ qua node_modules và dist nhờ file .gitignore)
git add .
git commit -m "Cap nhat AI-GV Toan Nang"

# Push lên GitHub
Write-Host "Đang upload code lên GitHub..." -ForegroundColor Yellow
git push -u origin main --force

if ($LASTEXITCODE -eq 0) {
    Write-Host "Chúc mừng! Upload thành công lên GitHub!" -ForegroundColor Green
} else {
    Write-Host "Có lỗi xảy ra trong quá trình upload. Hãy kiểm tra lại quyền truy cập hoặc tài khoản GitHub." -ForegroundColor Red
}
Pause
