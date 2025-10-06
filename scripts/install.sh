#!/bin/bash
# 🔐 Generator Key Nexus Corp - Instalador para Linux/macOS
# =========================================================

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variables
TOOL_NAME="nexus-keygen"
INSTALL_DIR="$HOME/.local/bin"
TOOL_URL="https://raw.githubusercontent.com/Corxo91/nexus-keygen/main/src/nexus-keygen.py"
VERSION="1.0.0"

# Funciones
print_banner() {
    echo -e "${PURPLE}================================================================================================${NC}"
    echo -e "${CYAN}🔐 GENERATOR KEY NEXUS CORP - INSTALADOR${NC}"
    echo -e "${PURPLE}   Universal Secure Key Generator v${VERSION}${NC}"
    echo -e "${PURPLE}================================================================================================${NC}"
    echo -e "${BLUE}🏢 NexusSecurity Development Tools${NC}"
    echo -e "${GREEN}🛡️  Instalador automático para Linux y macOS${NC}"
    echo -e "${PURPLE}------------------------------------------------------------------------------------------------${NC}"
}

check_requirements() {
    echo -e "${CYAN}🔍 Verificando requisitos...${NC}"
    
    # Verificar Python
    if ! command -v python3 &> /dev/null; then
        echo -e "${RED}❌ Python 3 no está instalado${NC}"
        echo -e "${YELLOW}💡 Instala Python 3 desde https://python.org o tu package manager${NC}"
        exit 1
    fi
    
    # Verificar versión de Python
    python_version=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
    echo -e "${GREEN}✅ Python ${python_version} encontrado${NC}"
    
    # Verificar curl
    if ! command -v curl &> /dev/null; then
        echo -e "${RED}❌ curl no está instalado${NC}"
        echo -e "${YELLOW}💡 Instala curl: sudo apt install curl (Ubuntu) o brew install curl (macOS)${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Todos los requisitos satisfechos${NC}"
}

create_install_dir() {
    echo -e "${CYAN}📁 Creando directorio de instalación...${NC}"
    
    if [ ! -d "$INSTALL_DIR" ]; then
        mkdir -p "$INSTALL_DIR"
        echo -e "${GREEN}✅ Directorio creado: $INSTALL_DIR${NC}"
    else
        echo -e "${YELLOW}📂 Directorio ya existe: $INSTALL_DIR${NC}"
    fi
}

download_tool() {
    echo -e "${CYAN}⬇️  Descargando Generator Key Nexus Corp...${NC}"
    
    local temp_file=$(mktemp)
    
    if curl -fsSL "$TOOL_URL" -o "$temp_file"; then
        # Verificar que el archivo descargado es válido
        if head -1 "$temp_file" | grep -q "#!/usr/bin/env python3"; then
            mv "$temp_file" "$INSTALL_DIR/$TOOL_NAME"
            chmod +x "$INSTALL_DIR/$TOOL_NAME"
            echo -e "${GREEN}✅ Herramienta descargada e instalada${NC}"
        else
            echo -e "${RED}❌ Archivo descargado inválido${NC}"
            rm -f "$temp_file"
            exit 1
        fi
    else
        echo -e "${RED}❌ Error descargando la herramienta${NC}"
        echo -e "${YELLOW}💡 Verifica tu conexión a internet${NC}"
        rm -f "$temp_file"
        exit 1
    fi
}

setup_path() {
    echo -e "${CYAN}🛤️  Configurando PATH...${NC}"
    
    # Detectar shell
    local shell_config=""
    local shell_name=$(basename "$SHELL")
    
    case "$shell_name" in
        bash)
            shell_config="$HOME/.bashrc"
            ;;
        zsh)
            shell_config="$HOME/.zshrc"
            ;;
        fish)
            shell_config="$HOME/.config/fish/config.fish"
            ;;
        *)
            shell_config="$HOME/.profile"
            ;;
    esac
    
    # Verificar si ya está en PATH
    if echo "$PATH" | grep -q "$INSTALL_DIR"; then
        echo -e "${GREEN}✅ $INSTALL_DIR ya está en PATH${NC}"
        return
    fi
    
    # Agregar al archivo de configuración del shell
    local path_line='export PATH="$HOME/.local/bin:$PATH"'
    
    if [ "$shell_name" = "fish" ]; then
        path_line='set -gx PATH $HOME/.local/bin $PATH'
    fi
    
    if ! grep -q "$INSTALL_DIR" "$shell_config" 2>/dev/null; then
        echo "" >> "$shell_config"
        echo "# Generator Key Nexus Corp" >> "$shell_config"
        echo "$path_line" >> "$shell_config"
        echo -e "${GREEN}✅ PATH agregado a $shell_config${NC}"
        echo -e "${YELLOW}⚠️  Reinicia tu terminal o ejecuta: source $shell_config${NC}"
    else
        echo -e "${YELLOW}📂 PATH ya configurado en $shell_config${NC}"
    fi
}

test_installation() {
    echo -e "${CYAN}🧪 Probando instalación...${NC}"
    
    # Verificar que el archivo existe y es ejecutable
    if [ -x "$INSTALL_DIR/$TOOL_NAME" ]; then
        echo -e "${GREEN}✅ Archivo instalado correctamente${NC}"
        
        # Probar ejecución
        if "$INSTALL_DIR/$TOOL_NAME" --version &> /dev/null; then
            echo -e "${GREEN}✅ Herramienta funciona correctamente${NC}"
        else
            echo -e "${YELLOW}⚠️  Herramienta instalada pero con advertencias${NC}"
        fi
    else
        echo -e "${RED}❌ Error en la instalación${NC}"
        exit 1
    fi
}

print_success() {
    echo -e "${PURPLE}================================================================================================${NC}"
    echo -e "${GREEN}🎉 ¡INSTALACIÓN COMPLETADA EXITOSAMENTE!${NC}"
    echo -e "${PURPLE}================================================================================================${NC}"
    echo ""
    echo -e "${CYAN}📋 ¿Cómo usar?${NC}"
    echo -e "   ${GREEN}$TOOL_NAME${NC}                    # Usar la herramienta"
    echo -e "   ${GREEN}$TOOL_NAME --help${NC}            # Ver ayuda"
    echo -e "   ${GREEN}$TOOL_NAME --version${NC}         # Ver versión"
    echo ""
    echo -e "${CYAN}📍 Instalado en:${NC} $INSTALL_DIR/$TOOL_NAME"
    echo ""
    echo -e "${YELLOW}💡 Si el comando no funciona:${NC}"
    echo -e "   ${BLUE}source ~/.bashrc${NC}             # Para Bash"
    echo -e "   ${BLUE}source ~/.zshrc${NC}              # Para Zsh"
    echo -e "   ${BLUE}source ~/.profile${NC}            # Para otros shells"
    echo ""
    echo -e "${PURPLE}🏢 NexusSecurity Development Tools${NC}"
    echo -e "${BLUE}🌐 Más herramientas en: https://security.nexuscorp-global.com${NC}"
    echo -e "${PURPLE}================================================================================================${NC}"
}

# Función principal
main() {
    print_banner
    echo ""
    
    # Verificar sistema operativo
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
        echo -e "${RED}❌ Este instalador es para Linux/macOS${NC}"
        echo -e "${YELLOW}💡 Para Windows, usa el instalador PowerShell:${NC}"
    echo -e "${BLUE}   irm https://raw.githubusercontent.com/Corxo91/nexus-keygen/main/scripts/install.ps1 | iex${NC}"
        exit 1
    fi
    
    check_requirements
    echo ""
    
    create_install_dir
    echo ""
    
    download_tool
    echo ""
    
    setup_path
    echo ""
    
    test_installation
    echo ""
    
    print_success
}

# Manejar Ctrl+C
trap 'echo -e "\n${RED}❌ Instalación cancelada por el usuario${NC}"; exit 1' INT

# Ejecutar
main "$@"