# azuresqldeploy
ARM Template for deploying Azure SQL in a Failover Group with monitoring and audit enabled.

## This template implements the following features
1. Creates a primary database 
2. Creates a failover group that references the server specified in the **sqlSecondaryServerName** parameter.
2. Enables Advanced Database Security and creates a storage account if the **enableADS** parameter is set to "true".

## Log analytics settings
### One way to determine the correct logs and metrics to add to the "providers/diagnosticSettings" is to do the following:
1. Use the Azure Portal and setup the desired diagnostic settings 
2. Use the Azure CLI and issue the following command **this example is for Azure SQL Database**
>`az monitor diagnostic-settings show --name [diagnostic name] --resource "/subscriptions/[subscription ID]/resourceGroups/[resource group name]/providers/Microsoft.Sql/servers/[server name]/databases/[database name]"`
3. Copy-paste the json arrays for Logs and Metrics into your template
