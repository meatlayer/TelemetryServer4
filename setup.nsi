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
UninstallIcon "TelemetryServer.ico"

# Only administrator
RequestExecutionLevel admin

Section "Install"
    SetOutPath $INSTDIR

    File /r "server\*.*"

    CreateShortCut "$DESKTOP\Telemetry Server 4.lnk" "$INSTDIR\Ets2Telemetry.exe" "" "" 0

    WriteUninstaller "$INSTDIR\uninstall.exe"

    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TelemetryServer" "DisplayName" "Telemetry Server v4.1.2.4"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TelemetryServer" "UninstallString" "$INSTDIR\uninstall.exe"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TelemetryServer" "InstallLocation" "$INSTDIR"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TelemetryServer" "DisplayIcon" "$INSTDIR\Ets2Telemetry.exe"
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TelemetryServer" "NoModify" 1
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TelemetryServer" "NoRepair" 1
SectionEnd

Section "Uninstall"
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TelemetryServer"

    Delete "$DESKTOP\Telemetry Server 4.lnk"

    RMDir /r "$INSTDIR"
SectionEnd
