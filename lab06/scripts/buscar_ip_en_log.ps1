# Patron para detectar direcciones IP (4 grupos de 1 a 3 digitos separados por puntos)
$patron = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'

# Log simulado
$log = @(
    "[2026-04-21 08:00] Conexion desde 192.168.1.10 aceptada",
    "[2026-04-21 08:05] Intento fallido desde 10.0.0.5",
    "[2026-04-21 08:10] Sin actividad registrada",
    "[2026-04-21 08:15] Conexion desde 172.16.0.3 rechazada"
)

foreach ($linea in $log) {
    if ($linea -match $patron) {
        Write-Host "IP encontrada: $($matches[0])  |  Linea: $linea"
    }
}
