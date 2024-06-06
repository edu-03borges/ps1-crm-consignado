# Obtém o caminho do diretório onde o script está localizado
$basePath = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define os repositórios e as pastas correspondentes
$repositories = @{
    "crm-backend-consignado"      = "https://github.com/edu-03borges/crm-backend-consignado.git"
    "automation-backend-consignado" = "https://github.com/edu-03borges/automation-backend-consignado.git"
    "crm-frontend-consignado"     = "https://github.com/edu-03borges/crm-frontend-consignado.git"
}

# Clona os repositórios se a pasta não existir
foreach ($folder in $repositories.Keys) {
    $folderPath = Join-Path -Path $basePath -ChildPath $folder
    if (-not (Test-Path -Path $folderPath)) {
        Write-Host "Clonando repositório $folder"
        git clone $repositories[$folder] $folderPath
    } else {
        Write-Host "O diretório $folderPath já existe. Pulando clonagem."
    }
}

# Loop através de cada subpasta e executa as operações necessárias
foreach ($folder in $repositories.Keys) {
    $folderPath = Join-Path -Path $basePath -ChildPath $folder
    $nodeModulesPath = Join-Path -Path $folderPath -ChildPath "node_modules"

    Write-Host "Verificando a existência de 'node_modules' em $folderPath"
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
