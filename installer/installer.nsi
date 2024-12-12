; Configuración inicial del instalador
Name "${NAME}"
OutFile "${NAME}.exe"
InstallDir "$PROGRAMFILES\${NAME}"
RequestExecutionLevel admin ; Requiere permisos de administrador

; Archivo de licencia

; Pantallas del instalador
Page components
Page directory
Page instfiles
UninstPage uninstConfirm
UninstPage instfiles

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
