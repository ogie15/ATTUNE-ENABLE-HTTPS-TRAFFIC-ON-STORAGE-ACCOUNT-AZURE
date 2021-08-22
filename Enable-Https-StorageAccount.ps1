#Region for ExecutionPolicy
# ===========================================================================
# Get Execution Policy of the current process
$Script:ProcessEP = Get-ExecutionPolicy -Scope Process

#Get the value of the Execution Policy and save it in the Variable
$Script:ValueProcessEP = ($Script:ProcessEP).value__

# Check if the Execution Policy of the process is set to Unrestricted
if ($Script:ValueProcessEP -eq 0) {

    # Write the message
    Write-Output "Execution Policy is already set to Unrestricted for the Process"
# Check if the Execution Policy of the process is already set
}else{

    # Set the ExecutionPolicy of the Process to Unrestricted
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force -Confirm:$false

    # Checks if the Execution Policy has been set
    if ((Get-ExecutionPolicy -Scope Process).value__ -eq 0) {

        # Write the message
        Write-Output "Execution Policy is now set to Unrestricted for the Process"
    }
}
# ===========================================================================
#EndRegion for ExecutionPolicy 




#Region Enable Https for StorageAccounts
# Import Module for AWS PowerShell
Import-Module -Name Az



#Region assign variables
# ===========================================================================
# Save accesskey to this Variable
$Script:UserName = "{azureusername.value}"

# Save secretkey to this variable
$Script:PasswordString = "{azurepassword.value}"
# ===========================================================================
#EndRegion assign variables



#Regoin for Connection to Azure 
# ===========================================================================
# Set the password and convert it to secure string to the variable
$Script:Password = ConvertTo-SecureString $Script:PasswordString -AsPlainText -Force

# set the credentials to the variable
$Script:UserCredential = New-Object System.Management.Automation.PSCredential ($Script:UserName,$Script:Password)

# Connect using set credentials to Azure
Connect-AzAccount -Credential $Script:UserCredential
# ===========================================================================
#Regoin for Connection to Azure 



# Get all Resources Groups and saves them in the Variable ALlRGS
$Script:AllRGS = Get-AzResourceGroup

# loops through all resource groups
foreach ($AllRG in $Script:AllRGS ) {

    # Set the variable for Rg name with no storage account 
    $Script:RGNameNS = ($AllRG).ResourceGroupName

    # Writes a message to the screen
    Write-Output "Checking if Resource Groups $Script:RGNameNS has Storage Accounts...... `n"

    # Gets all resources of resource type 'Microsoft.Storage/storageAccounts' from each resource group and saves it in a variable
    $Script:StorageAccounts = Get-AzResource -ResourceGroupName ($AllRG).ResourceGroupName | Where-Object { $_.ResourceType -like "Microsoft.Storage/storageAccounts" }

    # Set the variable for Rg name with storage account 
    $Script:RGName = ($Script:StorageAccounts).ResourceGroupName

    # checks if the variable is null
    if (!($Script:StorageAccounts)) {

        # Writes a message to the screen
        Write-Output "Resource Group $Script:RGNameNS has no Storage Account `n"

    }else{

        # Writes a message to the screen
        Write-Output "Resource Group $Script:RGName has Storage Account(s) `n"

        # looping through all storage accounts
        foreach ($StorageAccount in $Script:StorageAccounts) {

            # Set storage account name 
            $Script:StorageName = ($StorageAccount).Name

            # Set the variable for sub Rg name 
            $Script:RGNameSub = ($StorageAccount).ResourceGroupName

            # Writes a message to the screen
            Write-Output "Setting EnableHttpsTrafficeOnly property of Storage Account with Name '$Script:StorageName' - to True..... `n"

            # Pause Script for 1 millisecond in case Microsoft has any throttling Policy on CMDLET "Set-AzStorageAccount"
            Start-Sleep -Milliseconds 1

            # Set storage account EnableHttpsTrafficeOnly to $True
            Set-AzStorageAccount -ResourceGroupName $Script:RGNameSub -Name $Script:StorageName -EnableHttpsTrafficOnly $true -Force

            # Writes a message to the screen
            Write-Output "`n Done `n"

        }
    }
}
#EndRegion Enable Https for StorageAccounts



#Region Disconnect the Azure session
Disconnect-AzAccount
#EndRegion Disconnect the Azure session