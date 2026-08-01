# Configuration
$User = "campitos"
$Repo = "cuarto"
$Tag = "latest"  # Always update to 'latest'
$DockerHubImage = "$User/$($Repo):$Tag"
$BuildDir = "C:\Users\rapid\Documents\JAVA\cuarto"

# Verify Docker daemon is running and we are authenticated to a registry
Write-Host "Checking Docker daemon status..."
docker info > $null 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Docker daemon is not reachable. Start Docker Desktop and retry." -ForegroundColor Red
    exit 1
}

# Authenticate to Docker Hub if needed
$LoginCheck = docker info 2>&1 | Select-String -Pattern "Username"
if (-not $LoginCheck) {
    Write-Host "Not logged into Docker Hub. Running 'docker login'..." -ForegroundColor Yellow
    docker login -u $User
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Docker login failed. Check credentials and network." -ForegroundColor Red
        exit 1
    }
}

# Clear Docker cache (optional but recommended before fresh build)
Write-Host "Pruning Docker system..."
docker system prune -a --volumes -f

# Build image with --no-cache to force rebuild from scratch
Write-Host "Building Docker image $DockerHubImage with --no-cache..."
docker build --no-cache -t $DockerHubImage $BuildDir
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Docker build failed. Inspect the build output above." -ForegroundColor Red
    exit 1
}

# Push to Docker Hub (verify success via exit code, not local image cache)
Write-Host "Pushing $DockerHubImage to Docker Hub..."
docker push $DockerHubImage
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Push failed. Check Docker login or network." -ForegroundColor Red
    exit 1
}

Write-Host "✅ Image $DockerHubImage successfully pushed to Docker Hub!" -ForegroundColor Green
