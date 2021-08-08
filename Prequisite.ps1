#Region ================prequisite==========================
# Set the Execution Policy of the local machine to Unrestricted 
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine

# Install Az Module
Install-Module -Name Az -AllowClobber -Repository PSGallery -Force

# Install AzureRM Module
Install-Module -Name AzureRM -AllowClobber -Force

# Install Azure Module
Install-Module Azure -AllowClobber -Force
#EndRegion ================prequisite==========================



