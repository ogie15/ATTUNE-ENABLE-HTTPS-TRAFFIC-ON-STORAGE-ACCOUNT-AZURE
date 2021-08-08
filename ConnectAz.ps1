#Region ================connect==========================
# Set Admin User Name
$uname = "t"

# Set Admin Password
$pass = "B"

# Convert password to secure string
$password = ConvertTo-SecureString $pass -AsPlainText -Force

# Set Automation credential
$UserCredential = New-Object System.Management.Automation.PSCredential ($uname,$password)

# Connect to Azure
Connect-AzAccount -Credential $UserCredential

#EndRegion ================connect==========================
