# Run this script as Administrator

# Install IIS Role
Write-Host "Installing IIS Role..."
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Verify if IIS is installed
if ((Get-WindowsFeature -Name Web-Server).InstallState -eq "Installed") {
    Write-Host "IIS successfully installed!"
} else {
    Write-Host "IIS installation failed. Exiting script."
    exit
}

# Define the path for the default IIS site
$path = "C:\inetpub\wwwroot\index.html"

# Create a custom HTML page
Write-Host "Creating custom HTML page..."
$htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to IIS!</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; text-align: center; margin-top: 50px; }
        h1 { color: #333; }
        p { color: #666; }
    </style>
</head>
<body>
    <h1>Welcome to Your Custom IIS Page!</h1>
    <p>This page was deployed using a PowerShell script.</p>
</body>
</html>
"@

# Write the content to the index.html file
$htmlContent | Set-Content -Path $path -Force

# Set permissions to allow IIS to read the page
Write-Host "Setting permissions for IIS..."
$acl = Get-Acl $path
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("IIS_IUSRS","Read","Allow")
$acl.SetAccessRule($rule)
Set-Acl -Path $path -AclObject $acl

# Restart IIS to apply changes
Write-Host "Restarting IIS..."
iisreset

# Verify if the page is accessible
Write-Host "Opening the default browser to verify the page..."
Start-Process "http://localhost/index.html"

Write-Host "IIS setup complete with a custom HTML page!"
