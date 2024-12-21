; Usar Modern UI 2
!include "MUI2.nsh"

; Configuración inicial del instalador
Name "${NAME}"
OutFile "${NAME}.exe"
InstallDir "$PROGRAMFILES\${NAME}"
RequestExecutionLevel admin ; Requiere permisos de administrador

; Archivos de licencia y configuración visual
!define MUI_ICON "installer.ico"           ; Ícono del instalador
!define MUI_UNICON "uninstaller.ico"       ; Ícono del desinstalador
!insertmacro MUI_PAGE_LICENSE "license.txt" ; Página de licencia (opcional)
!define MUI_ABORTWARNING                  ; Advertencia al cancelar la instalación

; Pantallas del instalador
!insertmacro MUI_PAGE_WELCOME             ; Página de bienvenida
!insertmacro MUI_PAGE_COMPONENTS          ; Selección de componentes
!insertmacro MUI_PAGE_DIRECTORY           ; Selección de carpeta de instalación
!insertmacro MUI_PAGE_INSTFILES           ; Pantalla de instalación
!insertmacro MUI_PAGE_FINISH              ; Pantalla de finalización

; Pantallas del desinstalador
!insertmacro MUI_UNPAGE_CONFIRM           ; Confirmar desinstalación
!insertmacro MUI_UNPAGE_INSTFILES         ; Pantalla de desinstalación

; Lenguaje
!insertmacro MUI_LANGUAGE "Spanish"       ; Cambiar al español

; Secciones de instalación
Section "Aplicación principal" SEC01
    SetOutPath "$INSTDIR"
    File /r "..\${NAME}\bin\Release\*.*"
    CreateShortcut "$DESKTOP\${NAME}.lnk" "$INSTDIR\${NAME}.exe"
    WriteRegStr HKLM "Software\${NAME}" "Install_Dir" "$INSTDIR"
SectionEnd

Section -PostInstall
    WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

; Sección de desinstalación
Section "un.Uninstall"
    Delete "$INSTDIR\*.*"
    RMDir "$INSTDIR"
    Delete "$DESKTOP\${NAME}.lnk"
    DeleteRegKey HKLM "Software\${NAME}"
SectionEnd

; Configuración final del instalador
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
