#Region ================connect==========================
# Set Admin User Name
$uname = "tex_lag_ibok@tex.support.microsoft.com"

# Set Admin Password
$pass = "Beans@102"

# Convert password to secure string
$password = ConvertTo-SecureString $pass -AsPlainText -Force

# Set Automation credential
$UserCredential = New-Object System.Management.Automation.PSCredential ($uname,$password)

# Connect to Azure
Connect-AzAccount -Credential $UserCredential

#EndRegion ================connect==========================
