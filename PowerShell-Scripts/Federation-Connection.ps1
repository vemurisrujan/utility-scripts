Install-Module MSOnline -Force   # if not already installed
Import-Module MSOnline
$cred = Get-Credential           # enter tenant global admin
Connect-MsolService -Credential $cred

# Variables
$DomainName = "yourdomain.com"
$MetadataExchangeUri = "https://adfs.yourdomain.com/federationmetadata/2007-06/federationmetadata.xml"
$PassiveLogOnUri = "https://adfs.yourdomain.com/adfs/ls/"
$ActiveLogOnUri = "https://adfs.yourdomain.com/adfs/services/trust"
$LogOffUri = "https://adfs.yourdomain.com/adfs/ls/?wa=wsignout1.0"
$IssuerUri = "http://adfs.yourdomain.com/adfs/services/trust"
$FederationBrandName = "YourCompany SSO"
$PreferredAuthenticationProtocol = "SAMLP"
$SigningCertificate = Get-Content "C:\certs\idp-signing.cer" -Raw

# Configure federation
Set-MsolDomainAuthentication `
 -DomainName $DomainName `
 -FederationBrandName $FederationBrandName `
 -Authentication Federated `
 -MetadataExchangeUri $MetadataExchangeUri `
 -PassiveLogOnUri $PassiveLogOnUri `
 -ActiveLogOnUri $ActiveLogOnUri `
 -SigningCertificate $SigningCertificate `
 -IssuerUri $IssuerUri `
 -LogOffUri $LogOffUri `
 -PreferredAuthenticationProtocol $PreferredAuthenticationProtocol

# Verify
Get-MsolDomain -DomainName $DomainName
Get-MsolDomainFederationSettings -DomainName $DomainName