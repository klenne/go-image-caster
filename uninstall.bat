::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal
go build -ldflags="-H windowsgui"  -o image-caster.exe
set "installdir=C:\Program Files\image-caster"
set "exefile=image-caster.exe"

if not exist "%exefile%" (
    echo O arquivo "%exefile%" não foi encontrado no diretório atual.
    echo Certifique-se de que o executável está no mesmo diretório que este script.
    exit /b 1
)

rem Crie o diretório de instalação
mkdir "%installdir%" 2>nul

move "%exefile%" "%installdir%" >nul

set "inputFile=%%1"

reg add "HKEY_CLASSES_ROOT\*\shell\Convert to PNG" /ve /d "Convert to PNG" /f
reg add "HKEY_CLASSES_ROOT\*\shell\Convert to PNG\command" /ve /d "\"%installdir%\%exefile%\" -input \"%inputFile%\" -format png" /f

reg add "HKEY_CLASSES_ROOT\*\shell\Convert to JPEG" /ve /d "Convert to JPEG" /f
reg add "HKEY_CLASSES_ROOT\*\shell\Convert to JPEG\command" /ve /d "\"%installdir%\%exefile%\" -input \"%inputFile%\" -format jpeg" /f

echo Instalação concluída. O programa Image-Caster foi instalado e as opções "Convert to PNG" e "Convert to JPEG" foram adicionadas ao menu de contexto para extensões de imagem.

endlocal
