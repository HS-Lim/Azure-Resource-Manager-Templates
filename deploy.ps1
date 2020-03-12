$templatePath = './prt-master.deploy.json'
$parameterPath = './prt-master.parameters.json'

#Define functions here
function createRG {
    Write-Host "Creating a new resource group."

    New-AzResourceGroup -Name primaryPRT-RG -Location "West US"

    Write-Host "Successfully created new resource group."
}

function deployTemplate {
    Write-Host "Deploying template at $templatePath"
    New-AzResourceGroupDeployment `
    -Name master-deployment-final `
    -ResourceGroupName primaryPRT-RG `
    -TemplateFile $templatePath `
    -TemplateParameterFile $parameterPath
}

#Beginning of "main."
if(!(Get-Module "Az")) {
    Write-Host "Importing module Az"

    Import-Module Az
}
else {
    Write-Host "Module Az already loaded, proceeding..."
}

if(Get-AzContext) {
    Write-Host "Account detected, moving on..."
}
else {
    Write-Host "Connecting to account..."
    Connect-AzAccount
    Write-Host "Account connected."
}

deployTemplate

#Clear-AzContext
