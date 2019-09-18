
## Generate self-signed cert

```powershell
#
# Use proper provider so cert is accepted by AAD.
#
New-SelfSignedCertificate `
    -Subject "E=dude@localhost,CN=The Dude" `
    -CertStoreLocation "cert:\CurrentUser\My" `
    -KeyExportPolicy Exportable `
    -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" `
    -KeyAlgorithm RSA `
    -KeyLength 4096

Write-Output (Get-Item Cert:\CurrentUser\My\$($servicePrincipalConnection.CertificateThumbprint))

Add-AzureRmAccount `
    -ServicePrincipal `
    -TenantId "...." `
    -ApplicationId "..." `
    -CertificateThumbprint "2227B8175402AAF5BD4B5B80D51AB085EF61E7E8"
```

`Microsoft.IdentityModel.Clients.ActiveDirectory.AdalServiceException: AADSTS700021: Client assertion application identifier doesn't match 'client_id' parameter.`


- [8 Steps for Using Azure AD Service Principal Certificate Authentication with Azure Automation PowerShell Workflow Runbooks](https://blogs.technet.microsoft.com/keithmayer/2016/03/26/8-steps-for-using-azure-ad-service-principal-certificate-authentication-with-azure-automation-powershell-workflow-runbooks/)
