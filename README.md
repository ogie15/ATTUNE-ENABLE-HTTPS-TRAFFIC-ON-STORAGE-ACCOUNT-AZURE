# Using Attune to enable HTTPS traffic on all Azure Storage Accounts

This Blueprint is used to enable only HTTPS traffic on all Azure Storage Accounts.

An Azure storage account is a container that holds a set of Azure storage services together.

It holds Storage data objects like blobs, file shares, queues, tables, and disks.

The data is accessible from anywhere in the world over HTTP or HTTPS.

Information security audit requires storage accounts to accept requests from only secure connections (HTTPS).

The use of HTTPS protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking.

## Pre-Blueprint Attune setup

1. On the Inputs tab, create a Windows Node for the host you wish to run this Blueprint.
1. On the Inputs tab, create a Windows Credentials to connect to the host you wish to run this Blueprint.
1. On the Inputs tab, create a Text value to store the values below:
    - AzureUserName: This is the Username of the Azure Administrator (DataType: String).
    - AzurePassword: This is the Password of the Azure Administrator (DataType: String).

---

## Blueprint Steps

1. Check and Install the Azure AzPowerShell Module
1. Enable HTTPS traffic on all Azure Storage Accounts
