#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
🔐 Generator Key Nexus Corp - Universal Secure Key Generator
===========================================================

Generador universal de claves criptográficamente seguras para cualquier proyecto.
Desarrollado por NexusSecurity para facilitar el desarrollo de aplicaciones seguras.

Uso:
    nexus-keygen
    python3 nexus-keygen.py

Características:
- Claves de 32 o 64 caracteres
- Generación múltiple con menú interactivo
- Formatos: Alfanumérico + símbolos, Base64, Hexadecimal
- Historial de claves generadas en la sesión
- Interfaz amigable para desarrolladores
- Compatible con Windows, macOS y Linux
"""

import os
import secrets
import string
import base64
import platform
import sys
from typing import List, Dict
from datetime import datetime

# Configurar encoding para Windows
if sys.platform.startswith('win'):
    import locale
    if sys.stdout.encoding != 'utf-8':
        sys.stdout.reconfigure(encoding='utf-8', errors='replace')

__version__ = "1.0.0"
__author__ = "NexusSecurity Development Team"
__license__ = "MIT"

def safe_print(text: str):
    """Función para imprimir texto de manera segura en todos los sistemas"""
    try:
        print(text)
    except UnicodeEncodeError:
        # Fallback para sistemas con codificación limitada
        safe_text = text.encode('ascii', errors='replace').decode('ascii')
        print(safe_text)

class KeyGenerator:
    def __init__(self):
        self.generated_keys = []
        self.session_start = datetime.now()
        self.os_info = self.detect_os()
    
    def detect_os(self) -> Dict[str, str]:
        """Detecta el sistema operativo y devuelve información"""
        system = platform.system().lower()
        
        if system == "windows":
            os_name = "🪟 Windows"
            os_emoji = "🪟"
        elif system == "darwin":
            os_name = "🍎 macOS" 
            os_emoji = "🍎"
        elif system == "linux":
            os_name = "🐧 Linux"
            os_emoji = "🐧"
        else:
            os_name = f"❓ {system.title()}"
            os_emoji = "❓"
        
        return {
            "name": os_name,
            "emoji": os_emoji,
            "system": system,
            "version": platform.release(),
            "python": f"{sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}"
        }
    
    def generate_alphanumeric_key(self, length: int) -> str:
        """Genera clave alfanumérica con símbolos seguros"""
        alphabet = string.ascii_letters + string.digits + "!@#$%^&*()-_=+[]{}|;:,.<>?"
        return ''.join(secrets.choice(alphabet) for _ in range(length))
    
    def generate_base64_key(self, length: int) -> str:
        """Genera clave en base64"""
        # Para obtener aproximadamente 'length' caracteres en base64
        bytes_needed = (length * 3) // 4
        random_bytes = os.urandom(bytes_needed)
        key = base64.b64encode(random_bytes).decode('utf-8')
        return key[:length]  # Truncar al tamaño exacto
    
    def generate_hex_key(self, length: int) -> str:
        """Genera clave hexadecimal"""
        # Para obtener exactamente 'length' caracteres hex
        bytes_needed = length // 2
        return os.urandom(bytes_needed).hex()[:length]
    
    def clear_screen(self):
        """Limpiar pantalla según el SO"""
        if self.os_info['system'] == 'windows':
            os.system('cls')
        else:
            os.system('clear')
    
    def print_banner(self):
        """Muestra el banner de bienvenida"""
        print("\n" + "="*70)
        print("🔐 GENERATOR KEY NEXUS CORP")
        print(f"   Universal Secure Key Generator v{__version__}")
        print("="*70)
        print("🏢 NexusSecurity Development Tools")
        print("🛡️  Generador de claves criptográficamente seguras")
        print("📅 Sesión iniciada:", self.session_start.strftime("%Y-%m-%d %H:%M:%S"))
        print(f"{self.os_info['emoji']} Sistema: {self.os_info['name']} | Python {self.os_info['python']}")
        print("-"*70)
    
    def print_format_menu(self):
        """Muestra el menú de formatos disponibles"""
        print("\n🎯 SELECCIONA EL FORMATO DE CLAVE:")
        print("   1. Alfanumérica + Símbolos (Recomendada para JWT/Secrets)")
        print("   2. Base64 (Compatible con sistemas estrictos)")
        print("   3. Hexadecimal (Para encriptación/hashes)")
        print("-"*50)
    
    def print_length_menu(self):
        """Muestra el menú de longitudes"""
        print("\n📏 SELECCIONA LA LONGITUD:")
        print("   1. 32 caracteres (Estándar)")
        print("   2. 64 caracteres (Alta seguridad)")
        print("-"*50)
    
    def get_user_input(self, prompt: str, valid_options: List[str]) -> str:
        """Obtiene input del usuario validando las opciones"""
        while True:
            try:
                response = input(prompt).strip().lower()
                if response in valid_options:
                    return response
                print(f"❌ Opción inválida. Usa: {', '.join(valid_options)}")
            except KeyboardInterrupt:
                print("\n\n👋 Sesión interrumpida por el usuario")
                print("🏢 ¡Hasta la próxima!")
                sys.exit(0)
            except EOFError:
                print("\n\n👋 Sesión terminada")
                sys.exit(0)
    
    def get_quantity(self) -> int:
        """Obtiene la cantidad de claves a generar"""
        while True:
            try:
                quantity = int(input("🔢 ¿Cuántas claves quieres generar? (1-50): ").strip())
                if 1 <= quantity <= 50:
                    return quantity
                print("❌ Cantidad debe estar entre 1 y 50")
            except ValueError:
                print("❌ Por favor ingresa un número válido")
            except KeyboardInterrupt:
                print("\n\n👋 Sesión interrumpida por el usuario")
                sys.exit(0)
    
    def generate_keys(self, format_type: int, length: int, quantity: int) -> List[str]:
        """Genera las claves según los parámetros"""
        keys = []
        
        print(f"\n🔄 Generando {quantity} clave(s)...")
        
        for i in range(quantity):
            if format_type == 1:
                key = self.generate_alphanumeric_key(length)
            elif format_type == 2:
                key = self.generate_base64_key(length)
            else:  # format_type == 3
                key = self.generate_hex_key(length)
            
            keys.append(key)
        
        # Guardar en historial
        format_names = {1: "Alfanumérica", 2: "Base64", 3: "Hexadecimal"}
        self.generated_keys.append({
            'format': format_names[format_type],
            'length': length,
            'quantity': quantity,
            'keys': keys,
            'timestamp': datetime.now()
        })
        
        return keys
    
    def print_keys(self, keys: List[str], format_name: str, length: int):
        """Imprime las claves generadas"""
        print(f"\n✅ CLAVES GENERADAS ({format_name} - {length} caracteres):")
        print("="*60)
        
        for i, key in enumerate(keys, 1):
            print(f"🔑 Clave {i:2d}: {key}")
        
        print("="*60)
        print(f"📊 Total generadas: {len(keys)} claves")
        print(f"🔒 Entropía: ~{length * 6:.0f} bits de seguridad")
    
    def print_session_summary(self):
        """Imprime el resumen de toda la sesión"""
        if not self.generated_keys:
            return
        
        print(f"\n📋 TODAS LAS CLAVES GENERADAS EN ESTA SESIÓN")
        print("="*70)
        
        total_keys = 0
        all_keys_for_copy = []
        
        for session_idx, session in enumerate(self.generated_keys, 1):
            timestamp = session['timestamp'].strftime("%H:%M:%S")
            format_name = session['format']
            length = session['length']
            
            print(f"\n🕐 [{timestamp}] Grupo {session_idx}: {format_name} - {length} caracteres")
            print("-" * 60)
            
            for i, key in enumerate(session['keys'], 1):
                print(f"🔑 {key}")
                all_keys_for_copy.append(key)
            
            total_keys += session['quantity']
        
        # Sección especial: Todas las claves juntas para copiar fácil
        if len(self.generated_keys) > 1:
            print(f"\n📋 TODAS LAS CLAVES JUNTAS (fácil para copiar):")
            print("="*70)
            for i, key in enumerate(all_keys_for_copy, 1):
                print(f"KEY_{i:02d}={key}")
        
        # Estadísticas finales
        print("="*70)
        print(f"📊 ESTADÍSTICAS DE LA SESIÓN:")
        print(f"   • Total de claves generadas: {total_keys}")
        print(f"   • Grupos de generación: {len(self.generated_keys)}")
        duration = datetime.now() - self.session_start
        minutes, seconds = divmod(duration.seconds, 60)
        if minutes > 0:
            print(f"   • Duración: {minutes}m {seconds}s")
        else:
            print(f"   • Duración: {seconds} segundos")
        print(f"   • Seguridad: Todas criptográficamente seguras")
        print("="*70)
        
        # Consejos finales
        print(f"\n💡 CONSEJOS:")
        print("   • Copia las claves que necesites ANTES de cerrar la terminal")
        print("   • Guárdalas en tu archivo .env o gestor de contraseñas")
        print("   • NUNCA las subas a repositorios públicos")
        print("   • Usa claves diferentes para desarrollo y producción")
    
    def print_help(self):
        """Muestra información de ayuda"""
        print("\n🆘 AYUDA - Generator Key Nexus Corp")
        print("="*50)
        print("📖 Uso: nexus-keygen [opción]")
        print()
        print("🎯 Opciones disponibles:")
        print("   (ninguna)      Iniciar generador interactivo")
        print("   -h, --help     Mostrar esta ayuda")
        print("   -u, --uninstall Desinstalar la herramienta")
        print("   -v, --version Mostrar versión")
        print()
        print("🔐 Formatos de clave:")
        print("   1. Alfanumérica + Símbolos: A-Z, a-z, 0-9, símbolos")
        print("   2. Base64: Caracteres Base64 estándar")  
        print("   3. Hexadecimal: 0-9, a-f")
        print()
        print("📏 Longitudes:")
        print("   32 caracteres: ~192 bits entropía")
        print("   64 caracteres: ~384 bits entropía")
        print()
        print("🏢 Desarrollado por NexusSecurity")
        print("🌐 Más info: https://security.nexuscorp-global.com")
    
    def print_version(self):
        """Muestra información de versión"""
        safe_print(f"🔐 Generator Key Nexus Corp v{__version__}")
        safe_print(f"🏢 NexusSecurity Development Tools")
        safe_print(f"📅 Python {self.os_info['python']} en {self.os_info['name']}")
        safe_print(f"📜 Licencia: {__license__}")
        safe_print(f"👥 Autores: {__author__}")
    
    def uninstall(self):
        """Desinstala la herramienta del sistema"""
        print("\n🗑️  DESINSTALAR Generator Key Nexus Corp")
        print("="*50)
        print("⚠️  ¿Estás seguro de que quieres desinstalar la herramienta?")
        print("   Esto eliminará nexus-keygen de tu sistema.")
        print()
        
        confirm = input("🤔 Escriba 'SI' para confirmar: ").strip().upper()
        
        if confirm != 'SI':
            print("❌ Desinstalación cancelada")
            return
        
        print("\n🔍 Buscando instalaciones de nexus-keygen...")
        
        # Posibles ubicaciones donde puede estar instalado
        possible_locations = [
            os.path.expanduser("~/.local/bin/nexus-keygen"),
            "/usr/local/bin/nexus-keygen",
            "/usr/bin/nexus-keygen"
        ]
        
        # En Windows, verificar ubicaciones comunes
        if self.os_info['system'] == 'windows':
            possible_locations.extend([
                os.path.expandvars("$LOCALAPPDATA/NexusKeygen/nexus-keygen.py"),
                os.path.expandvars("$LOCALAPPDATA/NexusKeygen/nexus-keygen.bat"),
                "C:/Tools/NexusKeygen/nexus-keygen.py",
                "C:/Tools/NexusKeygen/nexus-keygen.bat"
            ])
        
        removed_files = []
        permission_errors = []
        
        for location in possible_locations:
            if os.path.exists(location):
                try:
                    os.remove(location)
                    removed_files.append(location)
                    print(f"✅ Eliminado: {location}")
                except PermissionError:
                    permission_errors.append(location)
                    print(f"❌ Sin permisos: {location}")
                except Exception as e:
                    print(f"❌ Error eliminando {location}: {e}")
        
        # En Windows, también intentar eliminar el directorio
        if self.os_info['system'] == 'windows':
            win_dirs = [
                os.path.expandvars("$LOCALAPPDATA/NexusKeygen"),
                "C:/Tools/NexusKeygen"
            ]
            
            for win_dir in win_dirs:
                if os.path.exists(win_dir):
                    try:
                        import shutil
                        shutil.rmtree(win_dir)
                        removed_files.append(win_dir)
                        print(f"✅ Directorio eliminado: {win_dir}")
                    except Exception as e:
                        print(f"⚠️  No se pudo eliminar directorio {win_dir}: {e}")
        
        print("\n" + "="*50)
        
        if removed_files:
            print(f"🎉 DESINSTALACIÓN COMPLETADA")
            print(f"   Se eliminaron {len(removed_files)} archivo(s)/directorio(s)")
            
            if permission_errors:
                print(f"\n⚠️  ARCHIVOS QUE REQUIEREN PERMISOS DE ADMINISTRADOR:")
                for file in permission_errors:
                    print(f"   {file}")
                
                if self.os_info['system'] == 'windows':
                    print("\n💡 Para eliminarlos manualmente:")
                    print("   - Abre PowerShell como Administrador")
                    for file in permission_errors:
                        print(f"   Remove-Item '{file}' -Force")
                else:
                    print("\n💡 Para eliminarlos manualmente:")
                    print("   sudo rm -f [archivo]")
            
            print(f"\n👋 ¡Generator Key Nexus Corp ha sido desinstalado!")
            print("🏢 ¡Gracias por usar herramientas de NexusSecurity!")
            
        else:
            print("🤷 No se encontraron instalaciones de nexus-keygen en el sistema")
            print("💡 La herramienta ya estaba desinstalada o se instaló en una ubicación no estándar")
    
    def run(self):
        """Ejecuta el generador con menú interactivo"""
        self.print_banner()
        
        while True:
            # Menú de formato
            self.print_format_menu()
            format_choice = self.get_user_input("👆 Elige formato (1/2/3): ", ["1", "2", "3"])
            format_type = int(format_choice)
            
            # Menú de longitud
            self.print_length_menu()
            length_choice = self.get_user_input("👆 Elige longitud (1/2): ", ["1", "2"])
            length = 32 if length_choice == "1" else 64
            
            # Cantidad
            quantity = self.get_quantity()
            
            # Generar claves
            format_names = {1: "Alfanumérica + Símbolos", 2: "Base64", 3: "Hexadecimal"}
            keys = self.generate_keys(format_type, length, quantity)
            
            # Mostrar claves
            self.print_keys(keys, format_names[format_type], length)
            
            # ¿Generar más del mismo formato?
            more_same = self.get_user_input(
                f"\n🔄 ¿Generar más claves {format_names[format_type]} de {length} caracteres? (S/N): ",
                ["s", "n", "si", "no"]
            )
            
            if more_same in ["s", "si"]:
                continue
            
            # ¿Generar de otro formato?
            other_format = self.get_user_input(
                "\n🎯 ¿Generar claves de otro formato? (S/N): ",
                ["s", "n", "si", "no"]
            )
            
            if other_format in ["n", "no"]:
                break
        
        # Resumen final
        self.print_session_summary()
        
        print("\n🎉 ¡GRACIAS POR USAR GENERATOR KEY NEXUS CORP!")
        print("🏢 NexusSecurity - Herramientas para desarrolladores")
        print("💡 Tip: Guarda tus claves de forma segura y nunca las subas a Git\n")

def main():
    """Función principal"""
    generator = KeyGenerator()
    
    # Manejar argumentos de línea de comandos
    if len(sys.argv) > 1:
        arg = sys.argv[1].lower()
        if arg in ['-h', '--help']:
            generator.print_help()
            return
        elif arg in ['-v', '--version']:
            generator.print_version()
            return
        elif arg in ['-u', '--uninstall']:
            generator.uninstall()
            return
        else:
            print(f"❌ Argumento desconocido: {sys.argv[1]}")
            print("💡 Usa -h para ver la ayuda")
            return
    
    # Ejecutar generador interactivo
    try:
        generator.run()
    except KeyboardInterrupt:
        print("\n\n👋 Sesión interrumpida por el usuario")
        print("🏢 ¡Hasta la próxima!")
    except Exception as e:
        print(f"\n❌ Error inesperado: {e}")
        print("🏢 Contacta al equipo de NexusSecurity si el problema persiste")
        print(f"🐛 Sistema: {generator.os_info['name']} | Python {generator.os_info['python']}")

if __name__ == "__main__":
    main()