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

# 3. Asignar usuarios a grupos
Write-Host "Asignando usuarios a grupos..."

$asignaciones = @(
    @{ Usuario = "ana.admin";     Grupo = "Administracion" },
    @{ Usuario = "bruno.soporte"; Grupo = "Soporte" },
    @{ Usuario = "carla.docente"; Grupo = "Docentes" }
)

foreach ($a in $asignaciones) {
    $existe = Get-LocalGroupMember -Group $a.Grupo | Where-Object { $_.Name -like "*$($a.Usuario)" }
    if ($existe) {
        Write-Host "Usuario '$($a.Usuario)' ya pertenece a '$($a.Grupo)'."
    } else {
        Add-LocalGroupMember -Group $a.Grupo -Member $a.Usuario
        Write-Host "Usuario '$($a.Usuario)' agregado a '$($a.Grupo)'."
    }
}

# 4. Estructura de carpetas C:\Empresa
Write-Host "Creando estructura de carpetas..."

$carpetas = @(
    "C:\Empresa",
    "C:\Empresa\Administracion",
    "C:\Empresa\Soporte",
    "C:\Empresa\Docentes",
    "C:\Empresa\Compartida"
)

foreach ($carpeta in $carpetas) {
    if (Test-Path $carpeta) {
        Write-Host "Carpeta '$carpeta' ya existe."
    } else {
        New-Item -ItemType Directory -Path $carpeta
        Write-Host "Carpeta '$carpeta' creada."
    }
}
