# 🔐 Generator Key Nexus Corp - Makefile
# ======================================

# Variables
TOOL_NAME = nexus-keygen
VERSION = 1.0.0
PYTHON = python3
BUILD_DIR = build
DIST_DIR = dist

# Colores para output
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
RED = \033[0;31m
NC = \033[0m # No Color

.PHONY: help install uninstall test clean build release dev lint

# Target por defecto
help:
	@echo "$(BLUE)🔐 Generator Key Nexus Corp - Makefile$(NC)"
	@echo "$(YELLOW)===========================================$(NC)"
	@echo ""
	@echo "$(GREEN)Comandos disponibles:$(NC)"
	@echo "  make install    - Instalar la herramienta localmente"
	@echo "  make uninstall  - Desinstalar la herramienta"
	@echo "  make test      - Ejecutar tests"
	@echo "  make lint      - Verificar código con flake8/pylint"
	@echo "  make clean     - Limpiar archivos temporales"
	@echo "  make build     - Crear distribución"
	@echo "  make release   - Crear release completo"
	@echo "  make dev       - Ejecutar en modo desarrollo"
	@echo ""
	@echo "$(BLUE)🏢 NexusSecurity Development Tools$(NC)"

# Instalar localmente
install:
	@echo "$(BLUE)📦 Instalando Generator Key Nexus Corp...$(NC)"
	@mkdir -p ~/.local/bin
	@cp src/$(TOOL_NAME).py ~/.local/bin/$(TOOL_NAME)
	@chmod +x ~/.local/bin/$(TOOL_NAME)
	@echo "$(GREEN)✅ Instalado en ~/.local/bin/$(TOOL_NAME)$(NC)"
	@echo "$(YELLOW)💡 Asegúrate de que ~/.local/bin esté en tu PATH$(NC)"

# Desinstalar
uninstall:
	@echo "$(BLUE)🗑️  Desinstalando Generator Key Nexus Corp...$(NC)"
	@rm -f ~/.local/bin/$(TOOL_NAME)
	@echo "$(GREEN)✅ Desinstalado$(NC)"

# Ejecutar en modo desarrollo
dev:
	@echo "$(BLUE)🚀 Ejecutando en modo desarrollo...$(NC)"
	@$(PYTHON) src/$(TOOL_NAME).py

# Tests básicos
test:
	@echo "$(BLUE)🧪 Ejecutando tests...$(NC)"
	@$(PYTHON) -c "import sys; sys.path.insert(0, 'src'); exec(open('src/$(TOOL_NAME).py').read().replace('if __name__ == \"__main__\":', 'if False:'))"
	@echo "$(GREEN)✅ Sintaxis correcta$(NC)"
	@$(PYTHON) src/$(TOOL_NAME).py --version > /dev/null && echo "$(GREEN)✅ Ejecución correcta$(NC)" || echo "$(RED)❌ Error en ejecución$(NC)"

# Lint (requiere flake8)
lint:
	@echo "$(BLUE)🔍 Verificando código...$(NC)"
	@if command -v flake8 >/dev/null 2>&1; then \
		flake8 src/$(TOOL_NAME).py --max-line-length=100 --ignore=E501,W503 && echo "$(GREEN)✅ Código verificado$(NC)"; \
	else \
		echo "$(YELLOW)⚠️  flake8 no instalado, saltando verificación$(NC)"; \
	fi

# Limpiar archivos temporales
clean:
	@echo "$(BLUE)🧹 Limpiando archivos temporales...$(NC)"
	@rm -rf __pycache__ .pytest_cache *.pyc *.pyo
	@rm -rf $(BUILD_DIR) $(DIST_DIR)
	@find . -name "*.pyc" -delete
	@find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
	@echo "$(GREEN)✅ Limpieza completada$(NC)"

# Crear build
build: clean
	@echo "$(BLUE)🔨 Creando build...$(NC)"
	@mkdir -p $(BUILD_DIR)
	@cp -r src scripts README.md LICENSE $(BUILD_DIR)/
	@echo "$(GREEN)✅ Build creado en $(BUILD_DIR)/$(NC)"

# Crear release completo
release: build
	@echo "$(BLUE)📦 Creando release v$(VERSION)...$(NC)"
	@mkdir -p $(DIST_DIR)
	@cd $(BUILD_DIR) && tar -czf ../$(DIST_DIR)/$(TOOL_NAME)-v$(VERSION).tar.gz .
	@cd $(BUILD_DIR) && zip -r ../$(DIST_DIR)/$(TOOL_NAME)-v$(VERSION).zip . > /dev/null
	@echo "$(GREEN)✅ Release creado:$(NC)"
	@echo "  $(DIST_DIR)/$(TOOL_NAME)-v$(VERSION).tar.gz"
	@echo "  $(DIST_DIR)/$(TOOL_NAME)-v$(VERSION).zip"

# Verificar instalación
check:
	@echo "$(BLUE)🔍 Verificando instalación...$(NC)"
	@if command -v $(TOOL_NAME) >/dev/null 2>&1; then \
		echo "$(GREEN)✅ $(TOOL_NAME) está instalado y disponible$(NC)"; \
		$(TOOL_NAME) --version; \
	else \
		echo "$(RED)❌ $(TOOL_NAME) no está disponible en PATH$(NC)"; \
	fi