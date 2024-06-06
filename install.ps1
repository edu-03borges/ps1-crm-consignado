# Obt�m o caminho do diret�rio onde o script est� localizado
$basePath = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define os reposit�rios e as pastas correspondentes
$repositories = @{
    "crm-backend-consignado"      = "https://github.com/edu-03borges/crm-backend-consignado.git"
    "automation-backend-consignado" = "https://github.com/edu-03borges/automation-backend-consignado.git"
    "crm-frontend-consignado"     = "https://github.com/edu-03borges/crm-frontend-consignado.git"
}

# Clona os reposit�rios se a pasta n�o existir
foreach ($folder in $repositories.Keys) {
    $folderPath = Join-Path -Path $basePath -ChildPath $folder
    if (-not (Test-Path -Path $folderPath)) {
        Write-Host "Clonando reposit�rio $folder"
        git clone $repositories[$folder] $folderPath
    } else {
        Write-Host "O diret�rio $folderPath j� existe. Pulando clonagem."
    }
}

# Loop atrav�s de cada subpasta e executa as opera��es necess�rias
foreach ($folder in $repositories.Keys) {
    $folderPath = Join-Path -Path $basePath -ChildPath $folder
    $nodeModulesPath = Join-Path -Path $folderPath -ChildPath "node_modules"

    Write-Host "Verificando a exist�ncia de 'node_modules' em $folderPath"
    if (Test-Path -Path $nodeModulesPath) {
        Write-Host "'node_modules' encontrado em $folderPath. Deletando..."
        Remove-Item -Recurse -Force -Path $nodeModulesPath
        Write-Host "'node_modules' deletado em $folderPath"
    }

    Write-Host "Executando 'npm install' em $folderPath"
    Set-Location -Path $folderPath
    npm install
}

Write-Host "Todos os comandos foram executados com sucesso."
