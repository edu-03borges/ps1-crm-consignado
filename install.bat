@echo off
setlocal

cd "./crm-backend-consignado"

if exist "node_modules" (
    echo Removendo a pasta "node_modules"...
    rd /s /q "node_modules"

    echo Instalando pacotes npm...
    start /B npm install
) else (
    echo Instalando pacotes npm...
    start /B npm install
)

cd ..

cd "./crm-frontend-consignado"

if exist "node_modules" (
    echo Removendo a pasta "node_modules"...
    rd /s /q "node_modules"

    echo Instalando pacotes npm...
    start /B npm install
) else (
    echo Instalando pacotes npm...
    start /B npm install
)

exit /b
endlocal
