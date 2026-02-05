Write-Host "🚀 Iniciando configuración del proyecto en Windows..." -ForegroundColor Cyan

# 1. Instalar dependencias de PHP
Write-Host "📦 Instalando dependencias de Composer..." -ForegroundColor Yellow
composer install

# 2. Copiar el archivo .env si no existe
if (-not (Test-Path ".env")) {
    Write-Host "📄 Copiando archivo .env..." -ForegroundColor Yellow
    Copy-Item ".env.example" -Destination ".env"
} else {
    Write-Host "⚠️ El archivo .env ya existe." -ForegroundColor DarkGray
}

# 3. Generar la llave
Write-Host "🔑 Generando llave de aplicación..." -ForegroundColor Yellow
php artisan key:generate

# 4. Crear archivo de base de datos SQLite (si no existe)
$dbFile = "database/database.sqlite"
if (-not (Test-Path $dbFile)) {
    Write-Host "🗄️ Creando archivo database.sqlite..." -ForegroundColor Yellow
    New-Item -Path $dbFile -ItemType File | Out-Null
}

# 5. Migraciones
Write-Host "⚡ Ejecutando migraciones..." -ForegroundColor Yellow
php artisan migrate --force

# 6. Frontend
Write-Host "🎨 Instalando y compilando assets (NPM)..." -ForegroundColor Yellow
call npm install
call npm run build

Write-Host "✅ ¡Todo listo! Ejecuta 'php artisan serve' para empezar." -ForegroundColor Green