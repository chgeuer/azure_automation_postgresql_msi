Write-Host (Get-Content -First 1 -Path $env:USERPROFILE\.pgpass).Split(":")[4].Trim()


