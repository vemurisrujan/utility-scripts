# Generate a self-signed certificate for SAML
$cert = New-SelfSignedCertificate -Subject "CN=<domain url>" -KeyAlgorithm RSA -KeyLength 3072 `
  -KeyUsage DigitalSignature, KeyEncipherment -NotAfter (Get-Date).AddYears(3) `
  -CertStoreLocation Cert:\CurrentUser\My -KeyExportPolicy Exportable

# Export cert to PFX (with password)
$mypwd = ConvertTo-SecureString "<password>" -AsPlainText -Force
Export-PfxCertificate -Cert $cert -FilePath "$env:USERPROFILE\Desktop\saml-signing.pfx" -Password $mypwd

# Export public certificate (CER)
Export-Certificate -Cert $cert -FilePath "$env:USERPROFILE\Desktop\saml-signing.cer"
