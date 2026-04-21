# Patron de validacion de email (Microsoft Learn)
$patron = '^[^@\s]+@[^@\s]+\.[^@\s]+$'

Import-Csv -Path "$PSScriptRoot\usuarios.csv" | ForEach-Object {
    if ($_.Email -match $patron) {
        Write-Host "OK:    $($_.Email)"
    } else {
        Write-Host "ERROR: $($_.Email) - formato invalido"
    }
}
