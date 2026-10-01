!include "MUI2.nsh"
!include "LogicLib.nsh"

# Имя и файл инсталлятора
Name "Telemetry Server v4.2.2.5"
OutFile "Telemetry Server Setup 4.2.2.5.exe"

# Стандартный путь по умолчанию
InstallDir "$DOCUMENTS\Telemetry Server"

# Считываем путь предыдущей установки из реестра (если был)
InstallDirRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TelemetryServer" "InstallLocation"

# Иконки и права
Icon "TelemetryServer.ico"
UninstallIcon "TelemetryServer.ico"
RequestExecutionLevel admin

# Страницы установки
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE English

Section "Install"
    # Флаг успешного удаления штатным деинсталлятором
    StrCpy $1 "0"

    # 1. Пробуем удалить через штатный деинсталлятор из реестра
    ReadRegStr $0 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TelemetryServer" "UninstallString"
    ${If} $0 != ""
    ${AndIf} ${FileExists} "$0"
        ExecWait '"$0" /S _?=$INSTDIR'
        StrCpy $1 "1" # Помечаем, что штатное удаление прошло
    ${EndIf}

    # 2. Если штатный деинсталлятор не сработал или не найден — ищем и удаляем папки по маске "$DOCUMENTS\Telemetry Server *"
    ${If} $1 == "0"
        FindFirst $2 $3 "$DOCUMENTS\Telemetry Server *"
        loop_find:
            ${If} $3 != ""
            ${AndIf} $3 != "."
            ${AndIf} $3 != ".."
                # Проверяем, что найденный объект — это директория
                ${If} ${FileExists} "$DOCUMENTS\$3\*.*"
                    RMDir /r "$DOCUMENTS\$3"
                ${EndIf}
                FindNext $2 $3
                Goto loop_find
            ${EndIf}
        FindClose $2
    ${EndIf}

    # 3. Установка новых файлов
    SetOutPath $INSTDIR
    File /r "server\*.*"

    # Ярлык
    CreateShortCut "$DESKTOP\Telemetry Server 4.lnk" "$INSTDIR\Ets2Telemetry.exe" "" "" 0

    # Создание деинсталлятора
    WriteUninstaller "$INSTDIR\uninstall.exe"

    # Запись в реестр
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TelemetryServer" "DisplayName" "Telemetry Server v4.2.2.5"
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