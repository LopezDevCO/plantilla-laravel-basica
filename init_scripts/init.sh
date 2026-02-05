#!/bin/bash

echo "🚀 Iniciando configuración del proyecto..."

# 1. Instalar dependencias de PHP (Laravel)
echo "📦 Instalando dependencias de Composer..."
composer install

# 2. Configurar el archivo de entorno .env
if [ ! -f .env ]; then
    echo "📄 Creando archivo .env..."
    cp .env.example .env
else
    echo "⚠️ El archivo .env ya existe, saltando este paso."
fi

# 3. Generar la llave de encriptación (APP_KEY)
echo "🔑 Generando llave de aplicación..."
php artisan key:generate

# 4. Configurar Base de Datos (SQLite)
# Esto crea el archivo vacío si no existe, para que no de error la migración
if [ ! -f database/database.sqlite ]; then
    echo "🗄️ Creando base de datos SQLite..."
    touch database/database.sqlite
fi

echo "migrando base de datos..."
php artisan migrate --force

# 5. Instalar y compilar dependencias de Frontend (Tailwind/Livewire styles)
echo "🎨 Instalando y compilando assets de Frontend..."
npm install
npm run build

echo "✅ ¡Todo listo! Tu proyecto está configurado."
echo "🌐 Ejecuta 'php artisan serve' para iniciar."