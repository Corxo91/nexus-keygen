# 🔐 Generator Key Nexus Corp - Instalador para Windows
# ====================================================
# Instalador PowerShell para Generator Key Nexus Corp
# Uso: irm https://raw.githubusercontent.com/Corxo91/nexus-keygen/main/scripts/install.ps1 | iex

param(
    [string]$InstallDir = "$env:LOCALAPPDATA\NexusKeygen",
    [switch]$Help,
    [switch]$Uninstall
)

# Variables globales
$ToolName = "nexus-keygen"
$ToolUrl = "https://raw.githubusercontent.com/Corxo91/nexus-keygen/main/src/nexus-keygen.py"
$Version = "1.0.0"

# Funciones de utilidad
function Write-ColoredOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    
    $colorMap = @{
        "Red" = "Red"
        "Green" = "Green" 
        "Yellow" = "Yellow"
        "Blue" = "Blue"
        "Cyan" = "Cyan"
        "Magenta" = "Magenta"
        "White" = "White"
    }
    
    Write-Host $Message -ForegroundColor $colorMap[$Color]
}

function Print-Banner {
    Write-ColoredOutput "================================================================================================" "Magenta"
    Write-ColoredOutput "🔐 GENERATOR KEY NEXUS CORP - INSTALADOR WINDOWS" "Cyan"
    Write-ColoredOutput "   Universal Secure Key Generator v$Version" "Magenta"
    Write-ColoredOutput "================================================================================================" "Magenta"
    Write-ColoredOutput "🏢 NexusSecurity Development Tools" "Blue"
    Write-ColoredOutput "🛡️  Instalador automático para Windows" "Green"
    Write-ColoredOutput "------------------------------------------------------------------------------------------------" "Magenta"
}

function Print-Help {
    Write-ColoredOutput "🆘 AYUDA - Instalador Generator Key Nexus Corp" "Cyan"
    Write-ColoredOutput "================================================" "Magenta"
    Write-Host ""
    Write-ColoredOutput "📖 Uso:" "Blue"
    Write-Host "   irm https://path/to/install.ps1 | iex                    # Instalación estándar"
    Write-Host "   irm https://path/to/install.ps1 | iex -InstallDir C:\Tools  # Directorio personalizado"
    Write-Host "   irm https://path/to/install.ps1 | iex -Uninstall        # Desinstalar"
    Write-Host ""
    Write-ColoredOutput "🎯 Opciones:" "Blue"
    Write-Host "   -InstallDir    Directorio de instalación (por defecto: %LOCALAPPDATA%\NexusKeygen)"
    Write-Host "   -Uninstall     Desinstalar la herramienta"
    Write-Host "   -Help          Mostrar esta ayuda"
    Write-Host ""
    Write-ColoredOutput "🏢 NexusSecurity Development Tools" "Magenta"
}

function Test-Prerequisites {
    Write-ColoredOutput "🔍 Verificando requisitos..." "Cyan"
    
    # Verificar Python
    try {
        $pythonVersion = python --version 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-ColoredOutput "✅ Python encontrado: $pythonVersion" "Green"
        } else {
            throw "Python no encontrado"
        }
    }
    catch {
        Write-ColoredOutput "❌ Python no está instalado o no está en PATH" "Red"
        Write-ColoredOutput "💡 Descarga Python desde https://python.org" "Yellow"
        Write-ColoredOutput "   Asegúrate de marcar 'Add to PATH' durante la instalación" "Yellow"
        return $false
    }
    
    # Verificar PowerShell versión
    $psVersion = $PSVersionTable.PSVersion
    if ($psVersion.Major -ge 5) {
        Write-ColoredOutput "✅ PowerShell $($psVersion.Major).$($psVersion.Minor) encontrado" "Green"
    } else {
        Write-ColoredOutput "⚠️  PowerShell versión antigua. Recomendado: 5.1+" "Yellow"
    }
    
    # Verificar permisos
    $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($currentUser)
    $isAdmin = $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
    
    if ($isAdmin) {
        Write-ColoredOutput "✅ Ejecutándose con permisos de administrador" "Green"
    } else {
        Write-ColoredOutput "⚠️  No se detectaron permisos de administrador" "Yellow"
        Write-ColoredOutput "   La instalación continuará en modo usuario" "Yellow"
    }
    
    Write-ColoredOutput "✅ Todos los requisitos verificados" "Green"
    return $true
}

function New-InstallDirectory {
    Write-ColoredOutput "📁 Creando directorio de instalación..." "Cyan"
    
    if (-not (Test-Path $InstallDir)) {
        try {
            New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
            Write-ColoredOutput "✅ Directorio creado: $InstallDir" "Green"
        }
        catch {
            Write-ColoredOutput "❌ Error creando directorio: $_" "Red"
            return $false
        }
    } else {
        Write-ColoredOutput "📂 Directorio ya existe: $InstallDir" "Yellow"
    }
    
    return $true
}

function Get-Tool {
    Write-ColoredOutput "⬇️  Descargando Generator Key Nexus Corp..." "Cyan"
    
    $toolPath = Join-Path $InstallDir "$ToolName.py"
    $batPath = Join-Path $InstallDir "$ToolName.bat"
    
    try {
        # Descargar archivo Python
        Invoke-WebRequest -Uri $ToolUrl -OutFile $toolPath -UseBasicParsing
        
        # Verificar que se descargó correctamente
        if (Test-Path $toolPath) {
            $content = Get-Content $toolPath -First 1
            if ($content -like "*#!/usr/bin/env python3*") {
                Write-ColoredOutput "✅ Herramienta descargada correctamente" "Green"
            } else {
                throw "Archivo descargado inválido"
            }
        } else {
            throw "No se pudo descargar el archivo"
        }
        
        # Crear script batch para Windows
        $batContent = "@echo off`npython `"$toolPath`" %*"
        Set-Content -Path $batPath -Value $batContent -Encoding ASCII
        
        Write-ColoredOutput "✅ Script batch creado: $ToolName.bat" "Green"
        
    }
    catch {
        Write-ColoredOutput "❌ Error descargando la herramienta: $_" "Red"
        Write-ColoredOutput "💡 Verifica tu conexión a internet" "Yellow"
        return $false
    }
    
    return $true
}

function Set-SystemPath {
    Write-ColoredOutput "🛤️  Configurando PATH del sistema..." "Cyan"
    
    # Obtener PATH actual del usuario
    $userPath = [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
    
    # Verificar si ya está en PATH
    if ($userPath -split ";" -contains $InstallDir) {
        Write-ColoredOutput "✅ $InstallDir ya está en PATH del usuario" "Green"
        return $true
    }
    
    try {
        # Agregar al PATH del usuario (no requiere admin)
        $newPath = if ($userPath) { "$userPath;$InstallDir" } else { $InstallDir }
        [Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::User)
        
        # Actualizar PATH de la sesión actual
        $env:Path = "$env:Path;$InstallDir"
        
        Write-ColoredOutput "✅ PATH actualizado para el usuario actual" "Green"
        Write-ColoredOutput "⚠️  Reinicia tu terminal para que los cambios tomen efecto" "Yellow"
        
    }
    catch {
        Write-ColoredOutput "❌ Error configurando PATH: $_" "Red"
        Write-ColoredOutput "💡 Puedes agregar manualmente '$InstallDir' a tu PATH" "Yellow"
        return $false
    }
    
    return $true
}

function Test-Installation {
    Write-ColoredOutput "🧪 Probando instalación..." "Cyan"
    
    $toolPath = Join-Path $InstallDir "$ToolName.py"
    $batPath = Join-Path $InstallDir "$ToolName.bat"
    
    # Verificar archivos
    if ((Test-Path $toolPath) -and (Test-Path $batPath)) {
        Write-ColoredOutput "✅ Archivos instalados correctamente" "Green"
        
        # Probar ejecución
        try {
            $testOutput = & python $toolPath --version 2>$null
            if ($LASTEXITCODE -eq 0) {
                Write-ColoredOutput "✅ Herramienta funciona correctamente" "Green"
            } else {
                Write-ColoredOutput "⚠️  Herramienta instalada pero con advertencias" "Yellow"
            }
        }
        catch {
            Write-ColoredOutput "⚠️  No se pudo probar la ejecución" "Yellow"
        }
    } else {
        Write-ColoredOutput "❌ Error en la instalación - archivos faltantes" "Red"
        return $false
    }
    
    return $true
}

function Remove-Tool {
    Write-ColoredOutput "🗑️  Desinstalando Generator Key Nexus Corp..." "Cyan"
    
    if (Test-Path $InstallDir) {
        try {
            Remove-Item $InstallDir -Recurse -Force
            Write-ColoredOutput "✅ Herramienta desinstalada" "Green"
            
            # Remover del PATH (opcional)
            $userPath = [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
            $pathList = $userPath -split ";" | Where-Object { $_ -ne $InstallDir }
            $newPath = $pathList -join ";"
            [Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::User)
            
            Write-ColoredOutput "✅ PATH limpiado" "Green"
        }
        catch {
            Write-ColoredOutput "❌ Error desinstalando: $_" "Red"
        }
    } else {
        Write-ColoredOutput "⚠️  No se encontró instalación existente" "Yellow"
    }
}

function Print-Success {
    Write-ColoredOutput "================================================================================================" "Magenta"
    Write-ColoredOutput "🎉 ¡INSTALACIÓN COMPLETADA EXITOSAMENTE!" "Green"
    Write-ColoredOutput "================================================================================================" "Magenta"
    Write-Host ""
    Write-ColoredOutput "📋 ¿Cómo usar?" "Cyan"
    Write-Host "   $ToolName                    # Usar la herramienta"
    Write-Host "   $ToolName --help            # Ver ayuda"  
    Write-Host "   $ToolName --version         # Ver versión"
    Write-Host ""
    Write-ColoredOutput "📍 Instalado en:" "Cyan"
    Write-Host "   $InstallDir"
    Write-Host ""
    Write-ColoredOutput "💡 Si el comando no funciona:" "Yellow"
    Write-Host "   • Reinicia tu terminal (PowerShell/CMD)"
    Write-Host "   • O usa la ruta completa: $InstallDir\$ToolName"
    Write-Host ""
    Write-ColoredOutput "🏢 NexusSecurity Development Tools" "Magenta"
    Write-ColoredOutput "🌐 Más herramientas en: https://security.nexuscorp-global.com" "Blue"
    Write-ColoredOutput "================================================================================================" "Magenta"
}

# Función principal
function Main {
    if ($Help) {
        Print-Help
        return
    }
    
    Print-Banner
    Write-Host ""
    
    if ($Uninstall) {
        Remove-Tool
        return
    }
    
    if (-not (Test-Prerequisites)) {
        exit 1
    }
    Write-Host ""
    
    if (-not (New-InstallDirectory)) {
        exit 1
    }
    Write-Host ""
    
    if (-not (Get-Tool)) {
        exit 1
    }
    Write-Host ""
    
    if (-not (Set-SystemPath)) {
        Write-ColoredOutput "⚠️  Instalación completada con advertencias" "Yellow"
    }
    Write-Host ""
    
    if (Test-Installation) {
        Write-Host ""
        Print-Success
    } else {
        Write-ColoredOutput "❌ La instalación no se completó correctamente" "Red"
        exit 1
    }
}

# Manejar Ctrl+C
trap {
    Write-ColoredOutput "`n❌ Instalación cancelada por el usuario" "Red"
    exit 1
}

# Ejecutar
Main