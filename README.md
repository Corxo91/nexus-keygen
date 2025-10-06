# 🔐 Generator Key Nexus Corp

**Universal Secure Key Generator** - Generador de claves criptográficamente seguras para cualquier proyecto.

[![Python 3.6+](https://img.shields.io/badge/python-3.6+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Cross-platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey)](https://github.com/Corxo91/nexus-keygen)

## 🎯 **¿Qué hace?**

Generator Key Nexus Corp es una herramienta de línea de comandos que genera claves seguras para:
- 🔑 **JWT Secrets** (JSON Web Tokens)
- 🛡️ **Claves de encriptación** (AES, Redis, etc.)
- 🔐 **API Keys** y tokens de autenticación
- 🗝️ **Passwords** y secrets de aplicaciones

## ✨ **Características**

- 🎯 **3 Formatos de clave**:
  - **Alfanumérica + Símbolos** (Recomendada para JWT/Secrets)
  - **Base64** (Compatible con sistemas estrictos)
  - **Hexadecimal** (Para encriptación y hashes)
  
- 📏 **2 Longitudes**: 32 o 64 caracteres
- 🔢 **Generación múltiple**: 1-50 claves por sesión
- 🖥️ **Multiplataforma**: Windows, macOS y Linux
- 🛡️ **Seguridad criptográfica**: Usa `secrets` module de Python
- 📋 **Resumen completo**: Todas las claves organizadas para copiar fácil
- 🎨 **Interfaz amigable**: Menú interactivo con emojis

## 🚀 **Instalación Rápida**

### **Requisitos**
- Python 3.6 o superior
- Sistema operativo: Windows, macOS o Linux

### **🪟 Windows**

#### Opción A: PowerShell (Recomendado)
```powershell
# Descargar e instalar
irm https://raw.githubusercontent.com/Corxo91/nexus-keygen/main/scripts/install.ps1 | iex

# Usar inmediatamente
nexus-keygen
```

#### Opción B: Manual
```cmd
# Descargar el archivo
curl -O https://raw.githubusercontent.com/Corxo91/nexus-keygen/main/src/nexus-keygen.py

# Crear directorio y mover
mkdir C:\Tools\NexusKeygen
move nexus-keygen.py C:\Tools\NexusKeygen\

# Agregar al PATH (PowerShell como Administrador)
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Tools\NexusKeygen", [System.EnvironmentVariableTarget]::Machine)

# Crear script batch
@echo @python "C:\Tools\NexusKeygen\nexus-keygen.py" %* > C:\Tools\NexusKeygen\nexus-keygen.bat
```

### **🐧 Linux**

#### Opción A: Script automático (Recomendado)
```bash
# Descargar e instalar
curl -fsSL https://raw.githubusercontent.com/Corxo91/nexus-keygen/main/scripts/install.sh | bash

# Usar inmediatamente
nexus-keygen
```

#### Opción B: Manual
```bash
# Descargar
curl -O https://raw.githubusercontent.com/Corxo91/nexus-keygen/main/src/nexus-keygen.py

# Instalar en directorio local
mkdir -p ~/.local/bin
chmod +x nexus-keygen.py
mv nexus-keygen.py ~/.local/bin/nexus-keygen

# Agregar al PATH (si no está)
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### **🍎 macOS**

#### Opción A: Script automático (Recomendado)
```bash
# Descargar e instalar  
curl -fsSL https://raw.githubusercontent.com/Corxo91/nexus-keygen/main/scripts/install.sh | bash

# Usar inmediatamente
nexus-keygen
```

#### Opción B: Manual
```bash
# Descargar
curl -O https://raw.githubusercontent.com/Corxo91/nexus-keygen/main/src/nexus-keygen.py

# Instalar
mkdir -p /usr/local/bin
chmod +x nexus-keygen.py
sudo mv nexus-keygen.py /usr/local/bin/nexus-keygen
```

## � **Descargas Directas por SO**

Si prefieres descargar los archivos manualmente en lugar de usar los instaladores automáticos:

### **🐧 Linux / 🍎 macOS**
**Formato recomendado**: `.tar.gz`

| Versión | Descarga | Tamaño | Fecha |
|---------|----------|---------|-------|
| **v1.0.0** | [📥 nexus-keygen-v1.0.0.tar.gz](https://github.com/Corxo91/nexus-keygen/releases/download/v1.0.0/nexus-keygen-v1.0.0.tar.gz) | ~15 KB | Oct 2025 |

### **🪟 Windows**
**Formato recomendado**: `.zip`

| Versión | Descarga | Tamaño | Fecha |
|---------|----------|---------|-------|
| **v1.0.0** | [📥 nexus-keygen-v1.0.0.zip](https://github.com/Corxo91/nexus-keygen/releases/download/v1.0.0/nexus-keygen-v1.0.0.zip) | ~15 KB | Oct 2025 |

### **📋 Instrucciones post-descarga:**

**Linux/macOS (después de descargar .tar.gz):**
```bash
# Extraer
tar -xzf nexus-keygen-v1.0.0.tar.gz
cd nexus-keygen-v1.0.0

# Instalar
chmod +x src/nexus-keygen.py
sudo cp src/nexus-keygen.py /usr/local/bin/nexus-keygen

# Verificar
nexus-keygen --version
```

**Windows (después de descargar .zip):**
```cmd
# Extraer el ZIP a C:\Tools\NexusKeygen\
# Luego agregar al PATH del sistema
# O usar directamente: python C:\Tools\NexusKeygen\src\nexus-keygen.py
```

> 💡 **Tip**: Los instaladores automáticos están disponibles en todas las versiones y son más fáciles de usar que las descargas manuales.

## �📋 **Uso**

### **Comandos disponibles**
```bash
nexus-keygen              # Generador interactivo
nexus-keygen --help       # Ver ayuda
nexus-keygen --version    # Ver versión
nexus-keygen --uninstall  # Desinstalar herramienta
```

### **Ejemplo de sesión**
```
🔐 GENERATOR KEY NEXUS CORP
======================================================================
🏢 NexusSecurity Development Tools
🛡️  Generador de claves criptográficamente seguras
🐧 Sistema: Linux | Python 3.9.2

🎯 SELECCIONA EL FORMATO DE CLAVE:
   1. Alfanumérica + Símbolos (Recomendada para JWT/Secrets)
   2. Base64 (Compatible con sistemas estrictos)
   3. Hexadecimal (Para encriptación/hashes)

👆 Elige formato (1/2/3): 1
👆 Elige longitud (1=32 / 2=64): 2
🔢 ¿Cuántas claves quieres generar? (1-50): 2

✅ CLAVES GENERADAS (Alfanumérica + Símbolos - 64 caracteres):
============================================================
🔑 Clave  1: KmN#2$qR9@vL3%wE6^yT4&uI7*oP0!sA5#dF8$gH1@nJ4%xZ7^cV2&
🔑 Clave  2: pL8#mK5@qW1$rT4^yU7*iO0!pA3#sD6$fG9&hB2%nM8@xC5^zQ1$

📊 RESUMEN FINAL con todas las claves para copiar fácil
```

## 🎯 **Casos de Uso Comunes**

### **Para JWT Secrets**
```bash
# Generar clave JWT de 64 caracteres
nexus-keygen
# Elige: 1 (Alfanumérica) → 2 (64 chars) → 1 (cantidad)
```

### **Para Redis/Encriptación**  
```bash
# Generar clave hexadecimal para encriptación
nexus-keygen
# Elige: 3 (Hexadecimal) → 2 (64 chars) → 1 (cantidad)
```

### **Para APIs estrictas**
```bash  
# Generar clave Base64 compatible
nexus-keygen
# Elige: 2 (Base64) → 2 (64 chars) → 1 (cantidad)
```

## 🛡️ **Seguridad**

- ✅ **Criptográficamente seguro**: Usa el módulo `secrets` de Python
- ✅ **Entropía alta**: ~192 bits (32 chars) o ~384 bits (64 chars)
- ✅ **Sin dependencias externas**: Solo Python estándar
- ✅ **No almacena claves**: Las claves solo existen en memoria durante la ejecución
- ✅ **Código abierto**: Puedes inspeccionar el código fuente

## 💡 **Tips y Mejores Prácticas**

### **🔐 Recomendaciones por uso**
| Uso | Formato | Longitud | Ejemplo |
|-----|---------|----------|---------|
| JWT Access Token | Alfanumérica | 64 chars | `JWT_ACCESS_SECRET` |
| JWT Refresh Token | Alfanumérica | 64 chars | `JWT_REFRESH_SECRET` |
| Redis Encryption | Hexadecimal | 64 chars | `REDIS_ENCRYPTION_KEY` |
| API Keys | Base64 | 32-64 chars | `API_SECRET_KEY` |
| Database Passwords | Alfanumérica | 32 chars | `DB_PASSWORD` |

### **🛡️ Seguridad**
- **NUNCA** subas claves generadas a repositorios públicos
- **USA** claves diferentes para desarrollo y producción  
- **GUARDA** las claves en gestores de contraseñas o variables de entorno
- **ROTA** las claves regularmente en producción

### **📁 Variables de entorno**
```bash
# Ejemplo de uso en .env
JWT_ACCESS_SECRET=KmN#2$qR9@vL3%wE6^yT4&uI7*oP0!sA5#dF8$gH1@nJ4%xZ7^cV2&
JWT_REFRESH_SECRET=pL8#mK5@qW1$rT4^yU7*iO0!pA3#sD6$fG9&hB2%nM8@xC5^zQ1$
REDIS_ENCRYPTION_KEY=2f11bbf98b6f68fcf8cf7d8428cd552296ab0ebeeafedd94d4badc90cbd13c07
```

## ❓ **Solución de Problemas**

### **Comando no encontrado**
```bash
# Linux/macOS
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Windows: Verificar que esté en PATH del sistema
```

### **Python no encontrado**
```bash
# Instalar Python desde https://python.org
# O usar package manager del sistema:

# Ubuntu/Debian
sudo apt update && sudo apt install python3

# macOS (Homebrew)
brew install python3

# Windows (Chocolatey)
choco install python3
```

### **Permisos denegados (Linux/macOS)**
```bash
# Dar permisos de ejecución
chmod +x ~/.local/bin/nexus-keygen

# O instalar con sudo (no recomendado)
sudo cp nexus-keygen.py /usr/local/bin/nexus-keygen
sudo chmod +x /usr/local/bin/nexus-keygen
```

## 🗑️ **Desinstalación**

### **Método automático (Recomendado)**
```bash
# Desinstalación automática con confirmación
nexus-keygen --uninstall
```

### **Método manual**
```bash
# Linux/macOS - Usuario local
rm -f ~/.local/bin/nexus-keygen

# Linux/macOS - Sistema (con sudo)
sudo rm -f /usr/local/bin/nexus-keygen

# Windows - PowerShell
Remove-Item "$env:LOCALAPPDATA\NexusKeygen" -Recurse -Force
# O eliminar de C:\Tools\NexusKeygen si se instaló ahí
```

## 🤝 **Contribuir**

¿Encontraste un bug o tienes una idea? ¡Contribuye!

1. **Fork** el repositorio
2. **Crea** una rama para tu feature: `git checkout -b feature/nueva-caracteristica`
3. **Commitea** tus cambios: `git commit -m 'Agregar nueva característica'`
4. **Push** a la rama: `git push origin feature/nueva-caracteristica`  
5. **Abre** un Pull Request

## 📜 **Licencia**

Este proyecto está bajo la licencia MIT. Ver [LICENSE](LICENSE) para más detalles.

## 🏢 **Acerca de NexusSecurity**

Generator Key Nexus Corp es desarrollado y mantenido por **NexusSecurity**, especialistas en herramientas de desarrollo y seguridad.

- 🌐 **Website**: [NexusSecurity](https://security.nexuscorp-global.com)
- 📧 **Email**: marcosjaviersantana300302@gmail.com
- 💼 **LinkedIn**: [NexusSecurity]()

---

**⭐ ¿Te gustó? ¡Dale una estrella en GitHub!**

---

*Hecho con ❤️ por el equipo de NexusSecurity*
