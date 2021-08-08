#Region Main Script
# Get all Resources Groups and saves them in the Variable ALlRGS
$AllRGS = Get-AzResourceGroup

# loops through all resource groups
foreach ($AllRG in $AllRGS ) {

    # Set the variable for Rg name with no storage account 
    $RGNameNS = ($AllRG).ResourceGroupName

    # Writes a message to screen
    Write-Output "Checking if Resource Groups $RGNameNS has Storage Accounts...... `n"

    # Gets all resources of resource type 'Microsoft.Storage/storageAccounts' from each resource group and saves it in a variable
    $StorageAccounts = Get-AzResource -ResourceGroupName ($AllRG).ResourceGroupName | Where-Object { $_.ResourceType -like "Microsoft.Storage/storageAccounts" }

    # Set the variable for Rg name with storage account 
    $RGName = ($StorageAccounts).ResourceGroupName

    # checks if the variable is null
    if (!($StorageAccounts)) {

        # Writes a message to screen
        Write-Output "Resource Group $RGNameNS has no Storage Account `n"

    }else{

        # Writes a message to screen
        Write-Output "Resource Group $RGName has Storage Account(s) `n"

        # looping through all storage accounts
        foreach ($StorageAccount in $StorageAccounts) {

            # Set storage account name 
            $StorageName = ($StorageAccount).Name

            # Set the variable for sub Rg name 
            $RGNameSub = ($StorageAccount).ResourceGroupName

            # Writes a message to screen
            Write-Output "Setting EnableHttpsTrafficeOnly property of Storage Account with Name '$StorageName' - to True..... `n"

            # Pause Script for 1 milliseconds in case Microsoft has any throttling Policy on CMDLET "Set-AzStorageAccount"
            Start-Sleep -Milliseconds 1

            # Set storage account EnableHttpsTrafficeOnly to $True
            Set-AzStorageAccount -ResourceGroupName $RGNameSub -Name $StorageName -EnableHttpsTrafficOnly $true -Force

            # Writes a message to screen
            Write-Output "`n Done `n"

        }
    }
}
#EndRegion Main Script