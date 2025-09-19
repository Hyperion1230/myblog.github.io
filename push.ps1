# HEXO Deployment Script (PowerShell Version)

# Set UTF-8 encoding to support international characters
$OutputEncoding = New-Object -typename System.Text.UTF8Encoding
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Get current time as default commit message
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$commitMessage = "Site updated: $timestamp"

# Check if command line arguments are provided as commit message
if ($args.Count -gt 0) {
    $commitMessage = $args -join " "
}

Write-Host "Starting HEXO deployment..." -ForegroundColor Green

try {
    # Clean old files
    Write-Host "Cleaning old files..." -ForegroundColor Yellow
    npx hexo clean
    
    # Generate static files
    Write-Host "Generating static files..." -ForegroundColor Yellow
    npx hexo generate
    
    # Deploy to GitHub Pages
    Write-Host "Deploying to GitHub Pages..." -ForegroundColor Yellow
    npx hexo deploy
    
    # Commit source code to repository
    Write-Host "Committing source code to repository..." -ForegroundColor Yellow
    git add .
    git commit -m "$commitMessage"
    git push
    
    Write-Host "Deployment completed successfully!" -ForegroundColor Green
}
catch {
    Write-Host "Error during deployment: $_" -ForegroundColor Red
    exit 1
}