!include "MUI2.nsh"
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE English

# Name and version
Name "Telemetry Server v4.1.2.4"
OutFile "Telemetry Server Setup 4.1.2.4.exe"

# Path install
InstallDir "$DOCUMENTS\Telemetry Server v4.1.2.4"

# Icon
Icon "TelemetryServer.ico"

# Only administrator
RequestExecutionLevel admin

# Installation
Section
    SetOutPath $INSTDIR

    ; Copy all files and folders
    File /r "server\*.*"

    ; Link on desktop
    CreateShortCut "$DESKTOP\Telemetry Server 4.lnk" "$INSTDIR\Ets2Telemetry.exe" "" "" 0

SectionEnd

# Removoe
Section "Uninstall"
    Delete $INSTDIR\*.*
    Delete "$DESKTOP\Telemetry Server 4.lnk"
    RMDir $INSTDIR
SectionEnd
