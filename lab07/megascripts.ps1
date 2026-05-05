#megascript con un montón de cosas

function Pausar($msg) {
    Write-Host "`n--- Fin: $msg ---"
    $r = Read-Host "Enter para continuar (n para salir)"
    if ($r -eq 'n') { Write-Host "Script interrumpido."; exit }
}

#1. creación de carpetas:

$base = "LaboratorioPS"

New-Item -ItemType Directory -Path $base -Force | Out-Null
Write-Host "Directorio creado: $base"
New-Item -ItemType Directory -Path "$base\Logs"     -Force | Out-Null
Write-Host "Directorio creado: $base\Logs"
New-Item -ItemType Directory -Path "$base\Reportes" -Force | Out-Null
Write-Host "Directorio creado: $base\Reportes"
New-Item -ItemType Directory -Path "$base\Respaldo"  -Force | Out-Null
Write-Host "Directorio creado: $base\Respaldo"

Pausar "Parte 1 - Creacion de carpetas"

#2. creación de archivos en Logs:

New-Item -ItemType File -Path "$base\Logs\log_error_01.txt" -Force | Out-Null
Write-Host "Archivo creado: log_error_01.txt"
New-Item -ItemType File -Path "$base\Logs\log_error_02.txt" -Force | Out-Null
Write-Host "Archivo creado: log_error_02.txt"
New-Item -ItemType File -Path "$base\Logs\log_info_01.txt"  -Force | Out-Null
Write-Host "Archivo creado: log_info_01.txt"
New-Item -ItemType File -Path "$base\Logs\usuarios.txt"     -Force | Out-Null
Write-Host "Archivo creado: usuarios.txt"
New-Item -ItemType File -Path "$base\Logs\ips.txt"          -Force | Out-Null
Write-Host "Archivo creado: ips.txt"

Pausar "Parte 2 - Creacion de archivos"

#3 y 4. carga de contenido a archivos:

# dataset usado: https://github.com/SoftManiaTech/sample_log_files/blob/master/Linux/Linux_2k.log
Set-Content -Path "$base\Logs\log_error_01.txt" -Value @"
Jan 04 15:16:01 combo sshd(pam_unix)[19939]: ERROR: authentication failure; rhost=218.188.2.4 user=root
Jan 05 02:04:59 combo sshd(pam_unix)[20882]: ERROR: authentication failure; rhost=220.135.151.1 user=root
Jan 05 04:06:18 combo su(pam_unix)[21416]: INFO: session opened for user cyrus by uid=0
Jan 05 04:06:20 combo logrotate[21420]: ERROR: proceso termino de forma anormal con codigo [1]
Jan 05 12:12:34 combo sshd(pam_unix)[23397]: ERROR: authentication failure; rhost=218.188.2.4 user=admin
Jan 05 14:53:32 combo sshd(pam_unix)[23661]: ERROR: authentication failure; rhost=61.92.85.98 user=test
Jan 05 20:05:31 combo sshd(pam_unix)[24138]: ERROR: authentication failure; rhost=211.116.254.214 user=root
Jan 07 07:07:00 combo ftpd[29504]: INFO: connection from IP: 24.54.76.216 aceptada
Jan 07 20:29:26 combo sshd(pam_unix)[30631]: INFO: session opened for user test uid=509
Jan 08 01:30:59 combo sshd(pam_unix)[31201]: ERROR: authentication failure; rhost=70.242.75.179 user=root
Jan 08 02:08:10 combo ftpd[31272]: INFO: connection from IP: 82.252.162.81 aceptada
Jan 09 04:09:11 combo syslogd[1]: INFO: syslogd reiniciado correctamente
Jan 09 10:08:19 combo sshd(pam_unix)[15481]: ERROR: authentication failure; rhost=163.27.187.39 user=root
Jan 10 20:53:04 combo klogind[19272]: ERROR: autenticacion fallida desde IP: 163.27.187.39 - Permission denied
Jan 10 22:16:32 combo sshd(pam_unix)[19432]: INFO: session opened for user test uid=509
Ticket 10234 generado
mail: soporte@empresa.com
IP: 192.168.1.25
"@
Write-Host "Contenido cargado en log_error_01.txt"

Set-Content -Path "$base\Logs\log_error_02.txt" -Value @"
Jan 01 08:56:36 combo sshd(pam_unix)[14281]: ERROR: authentication failure; rhost=217.60.212.66 user=guest
Jan 02 03:17:26 combo sshd(pam_unix)[16207]: ERROR: authentication failure; rhost=219.76.184.117 user=root
Jan 03 01:41:29 combo sshd(pam_unix)[18969]: ERROR: authentication failure; rhost=209.152.168.249 user=guest
Jan 07 08:05:37 combo sshd(pam_unix)[8660]: ERROR: authentication failure; rhost=61.53.154.93 user=root
Jan 08 08:10:24 combo sshd(pam_unix)[11513]: ERROR: authentication failure; rhost=61.53.154.93 user=root
Jan 08 20:58:46 combo sshd(pam_unix)[12665]: ERROR: authentication failure; rhost=62.192.102.94 user=root
Jan 09 03:22:22 combo ftpd[13262]: INFO: connection from IP: 61.74.96.178 aceptada
Jan 09 10:08:19 combo sshd(pam_unix)[15481]: ERROR: authentication failure; rhost=163.27.187.39 user=root
Jan 10 12:48:38 combo sshd(pam_unix)[18559]: ERROR: authentication failure; rhost=203.101.45.59 user=unknown
Jan 10 20:53:04 combo klogind[19272]: ERROR: autenticacion fallida desde IP: 163.27.187.39 - Permission denied
Jan 10 07:57:30 combo ftpd[21952]: INFO: connection from IP: 202.82.200.188 aceptada
Jan 02 13:16:30 combo ftpd[17886]: INFO: connection from IP: 210.245.165.136 aceptada
Ticket 99821 generado
mail: admin@empresa.com
fecha: 2026-01-10
"@
Write-Host "Contenido cargado en log_error_02.txt"

Set-Content -Path "$base\Logs\log_info_01.txt" -Value @"
Jan 05 04:06:18 combo su(pam_unix)[21416]: INFO: session opened for user cyrus uid=0
Jan 05 04:06:19 combo su(pam_unix)[21416]: INFO: session closed for user cyrus uid=0
Jan 06 04:10:22 combo su(pam_unix)[25178]: INFO: session opened for user cyrus uid=0
Jan 07 04:03:33 combo su(pam_unix)[27953]: INFO: session opened for user cyrus uid=0
Jan 07 20:29:26 combo sshd(pam_unix)[30631]: INFO: session opened for user test uid=509
Jan 08 04:07:05 combo su(pam_unix)[31791]: INFO: session opened for user cyrus uid=0
Jan 09 04:08:55 combo su(pam_unix)[2192]: INFO: session opened for user cyrus uid=0
Jan 09 04:09:11 combo syslogd[1]: INFO: syslogd reiniciado correctamente
Jan 10 22:16:32 combo sshd(pam_unix)[19432]: INFO: session opened for user test uid=509
Jan 02 01:41:32 combo sshd(pam_unix)[23533]: INFO: session opened for user test uid=509
INFO: respaldo completado exitosamente el 2026-01-10
INFO: reporte generado el 2026-01-09
mail: ana.perez@empresa.com
mail: soporte@empresa.com
Ticket 55678 generado
IP: 172.16.0.1
"@
Write-Host "Contenido cargado en log_info_01.txt"

Set-Content -Path "$base\Logs\usuarios.txt" -Value @"
usuario: root
usuario: cyrus
usuario: test
usuario: guest
usuario: admin
usuario: ana.perez
usuario: juan.lopez
usuario: carlos.gomez
usuario: maria.rodriguez
"@
Write-Host "Contenido cargado en usuarios.txt"

Set-Content -Path "$base\Logs\ips.txt" -Value @"
IP: 218.188.2.4
IP: 220.135.151.1
IP: 24.54.76.216
IP: 82.252.162.81
IP: 70.242.75.179
IP: 65.166.159.14
IP: 217.60.212.66
IP: 209.152.168.249
IP: 61.74.96.178
IP: 163.27.187.39
IP: 202.82.200.188
IP: 210.245.165.136
IP: 192.168.1.1
IP: 172.16.0.254
IP: 10.10.10.10
"@
Write-Host "Contenido cargado en ips.txt"

Pausar "Partes 3 y 4 - Carga de contenido"

#5. navegación y listado:

Write-Host "`nUbicacion actual:"
Get-Location

Set-Location $base
Write-Host "Cambiado a: $base"

Write-Host "`nContenido recursivo de ${base}:"
Get-ChildItem -Recurse

Set-Location ..

Pausar "Parte 5 - Navegacion y listado"

#6. búsqueda por nombre:

Write-Host "`nTodos los archivos .txt:"
Get-ChildItem -Path $base -Recurse -Filter "*.txt"

Write-Host "`nArchivos que comienzan con log_:"
Get-ChildItem -Path $base -Recurse | Where-Object { $_.Name -like "log_*" }

Write-Host "`nArchivos que cumplen regex (log_ ... .txt):"
Get-ChildItem -Path $base -Recurse | Where-Object { $_.Name -match "^log_.*\.txt$" }

Pausar "Parte 6 - Busqueda por nombre"

#7. búsqueda de texto dentro de archivos:

$archivos = Get-ChildItem -Path $base -Recurse -Filter "*.txt"
$resultados = "$base\Logs\resultados.txt"

"=== Lineas que contienen ERROR ===" | Set-Content $resultados
$archivos | Select-String -Pattern "ERROR" | Out-String | Add-Content $resultados
Write-Host "Busqueda ERROR completada"

"=== Lineas que contienen direcciones IP ===" | Add-Content $resultados
$archivos | Select-String -Pattern "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b" | Out-String | Add-Content $resultados
Write-Host "Busqueda IPs completada"

# patron basado en Microsoft Learn: '^[^@\s]+@[^@\s]+\.[^@\s]+$'
# se quitan ^ y $ porque Select-String busca dentro de la linea, no coincidencia exacta de linea completa
"=== Lineas que contienen correos electronicos ===" | Add-Content $resultados
$archivos | Select-String -Pattern "[^@\s]+@[^@\s]+\.[^@\s]+" | Out-String | Add-Content $resultados
Write-Host "Busqueda emails completada"

"=== Lineas que contienen numeros de ticket ===" | Add-Content $resultados
$archivos | Select-String -Pattern "Ticket\s+\d+" | Out-String | Add-Content $resultados
Write-Host "Busqueda tickets completada"

Write-Host "Resultados guardados en: $resultados"

Pausar "Parte 7 - Busqueda de texto dentro de archivos"

#8. RegEx - detectar archivos cuyo contenido contenga patrones:
#Cambia respecto a el ejercicio anterior ya que aqui tengo que buscar que archivos presentan estos patrones. y no al reves
Write-Host "`nArchivos con direcciones IP:"
$archivos | Where-Object { (Get-Content $_.FullName) -match "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b" } | Select-Object Name

Write-Host "`nArchivos con correos electronicos:"
$archivos | Where-Object { (Get-Content $_.FullName) -match "[^@\s]+@[^@\s]+\.[^@\s]+" } | Select-Object Name

Write-Host "`nArchivos con lineas que comienzan con ERROR:"
$archivos | Where-Object { (Get-Content $_.FullName) -match "^ERROR" } | Select-Object Name

Write-Host "`nArchivos con tickets de 5 digitos:"
$archivos | Where-Object { (Get-Content $_.FullName) -match "Ticket\s+\d{5}" } | Select-Object Name

Pausar "Parte 8 - RegEx"

#9. generación de reporte:

$reporte = "$base\Reportes\reporte_auditoria.txt"

$totalTxt = (Get-ChildItem -Path $base -Recurse -Filter "*.txt").Count
$logsArchivos = Get-ChildItem -Path "$base\Logs" -Filter "log_*.txt" | Select-Object -ExpandProperty Name
$errores = $archivos | Select-String -Pattern "ERROR"
$emails = $archivos | Select-String -Pattern "[^@\s]+@[^@\s]+\.[^@\s]+"
$ips = $archivos | Select-String -Pattern "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"
$tickets = $archivos | Select-String -Pattern "Ticket\s+\d{5}"

Set-Content -Path $reporte -Value "Reporte de auditoria - $(Get-Date)"
Add-Content -Path $reporte -Value ""
Add-Content -Path $reporte -Value "Total de archivos .txt: $totalTxt"
Add-Content -Path $reporte -Value ""
Add-Content -Path $reporte -Value "Archivos log_*.txt:"
$logsArchivos | Add-Content -Path $reporte
Add-Content -Path $reporte -Value ""
Add-Content -Path $reporte -Value "Coincidencias ERROR:"
$errores | Add-Content -Path $reporte
Add-Content -Path $reporte -Value ""
Add-Content -Path $reporte -Value "Correos electronicos:"
$emails | Add-Content -Path $reporte
Add-Content -Path $reporte -Value ""
Add-Content -Path $reporte -Value "Direcciones IP:"
$ips | Add-Content -Path $reporte
Add-Content -Path $reporte -Value ""
Add-Content -Path $reporte -Value "Tickets:"
$tickets | Add-Content -Path $reporte

Write-Host "Reporte generado en: $reporte"

Pausar "Parte 9 - Generacion de reporte"

#10. copiar reporte a Respaldo:

Copy-Item -Path $reporte -Destination "$base\Respaldo\"
Write-Host "Reporte copiado a: $base\Respaldo\"

Write-Host "`n--- Fin: Parte 10 - Copia a Respaldo ---"
Write-Host "Script completado."
