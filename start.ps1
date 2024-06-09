# Obtém o caminho do diretório onde o script está localizado
$basePath = Split-Path -Parent $MyInvocation.MyCommand.Path

# Função para iniciar um comando npm em um diretório específico
function Start-NpmCommand {
    param (
        [string]$folder,
        [string]$command
    )
    $folderPath = Join-Path -Path $basePath -ChildPath $folder
    Write-Host "Iniciando '$command' em $folderPath"
    Start-Process -FilePath "npm" -ArgumentList "run $command" -WorkingDirectory $folderPath -NoNewWindow
}

# Inicia os comandos npm nos diretórios específicos
Start-NpmCommand -folder "crm-backend-consignado" -command "dev"
Start-NpmCommand -folder "crm-frontend-consignado" -command "start"

Write-Host "Todos os comandos npm foram iniciados."
