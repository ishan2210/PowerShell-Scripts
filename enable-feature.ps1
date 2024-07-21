$feature = Get-WindowsOptionalFeature -Online -FeatureName 'Windows-ApplicationGuard'
$state = $feature.State
if ($state -eq 'Disabled')
{
 Enable-WindowsOptionalFeature -online -FeatureName Windows-Defender-ApplicationGuard
}
 else
{
 exit 
}
