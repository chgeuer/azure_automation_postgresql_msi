# `azure_automation_postgresql_msi` - A demo bringing together Azure Automation, PostgreSQL and user-assigned managed identity.

## Requirements

- A multi-tenant SaaS solution stores tenant-specific management information in PostgreSQL.
  - Such management information could be a list of customer tenants, alongside with the Azure subscription IDs.
- Azure Automation should be able to fetch management information from that PostgreSQL instance.
- Azure Automation should be able to communicate with a PostgreSQL endpoint,
  which is not public accessible on the Internet, but only visible within an Azure VNET.
- Azure Automation should be able to manage resources in multiple Azure subscriptions.
- All sensitive information (connection strings, etc.) should be stored in Azure KeyVault.
- Favor 'user-assigned managed identity' over service principals.
  - Whereever possible, try to avoid Azure service principals.
  - 'Regular' service principals require that the applications securely handle the SP's secret/password/certificate.

## Props

- A user-assigned managed identity which is authorized for a few things:
  - Fetch the PostgreSQL database connection string from KeyVault
  - Has contributor rights on subscriptions, or individual resource groups
- A hybrid worker VM,
  - which has PostgreSQL ODBC driver installed,
  - which has access to that user-assigned identity,
  - is conneced to Azure Automation and can run the Powershell runbook runs, which
    - uses the user-assigned identity to fetch PostgreSQL connection information from KeyVault
    - establish a SQL connection to PostgreSQL,
    - retrieve the list of tenants and subscriptions (using the ODBC driver using .NET from PowerShell)
  - Connect to these subscriptions or resource groups, and do some Azure management operation,
    such as listing all resource groups etc
  - No local SP credentials stored on the VM
- An Azure Automation account in which I can do the same as the hybrid worker VM (also connect to PostgreSQL),
  just with the difference that it uses the Azure Automation account’s service principal account,
  instead of a user-assigned identity.
- An Azure Image Builder which creates VM images to be used for the hybrid worker VM

- The idea for using a hybrid worker VM with Azure Automation was that, if the PostgreSQL DB is only
  reachable inside a VNET, instead of exposing a public (Internet) endpoint. When using a private endpoint
  for PostgreSQL, there’s a fair chance that Azure Automation-hosted runbooks would not be able to connect
  to the private PostgreSQL instance. Having a VM image, we can simply spin a VM for Azure Automation
  in a VNET of your choice…

## Result

- No service principals needed. Only user-assigned managed identity. No SP credentials on VMs.
- Azure Automation scripts using data from PostgreSQL database. Azure Automation being able
  to access PostgreSQL DB, even with Private Link.
- Support for multiple subscriptions.
