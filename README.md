# azuresqldeploy
ARM Template for deploying Azure SQL in a Failover Group with monitoring and audit enabled.

## This template implements the following features
1. Creates a primary database 
2. Creates a failover group that references the server specified in the **sqlSecondaryServerName** parameter.
2. Enables Advanced Database Security and creates a storage account if the **enableADS** parameter is set to "true".
