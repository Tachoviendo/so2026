# Tarea 03 - Sistemas Operativos - UCU
# Script de configuracion inicial - Instituto "Anda a Saber"

# 1. Grupos locales
Write-Host "Creando grupos locales..."

$grupos = @("Administracion", "Soporte", "Docentes")

foreach ($grupo in $grupos) {
      $existe = Get-LocalGroup | Where-Object { $_.Name -eq $grupo }
      if ($existe) {
          Write-Host "Grupo '$grupo' ya existe."
      } else {
          New-LocalGroup -Name $grupo
          Write-Host "Grupo '$grupo' creado."
      }
}
