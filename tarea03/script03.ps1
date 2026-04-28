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

# 2. Usuarios locales
Write-Host "Creando usuarios locales..."

$usuarios = @("ana.admin", "bruno.soporte", "carla.docente")

foreach ($usuario in $usuarios) {
    $existe = Get-LocalUser | Where-Object { $_.Name -eq $usuario }
    if ($existe) {
        Write-Host "Usuario '$usuario' ya existe."
    } else {
        $pass = ConvertTo-SecureString "nacho123!" -AsPlainText -Force #tuve que poner -Force porque sino me daba error. 
        New-LocalUser -Name $usuario -Password $pass 
        Write-Host "Usuario '$usuario' creado."
    }
}
