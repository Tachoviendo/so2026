# Manual de Usuario - script03.ps1
Estudiante: Silva, Ignacio

Universidad Católica

Asignatura: Sistemas Operativos

Docente: Jorge Martínez

Fecha: 28 de marzo de 2026


## Descripcion

Script de PowerShell que automatiza la configuracion inicial de un equipo Windows para el Instituto "Anda a Saber". Crea grupos, usuarios, estructura de carpetas y realiza un respaldo automatico.


## Requisitos previos

- Windows 10/11 o Windows Server
- Cuenta con permisos de Administrador


## Pasos para ejecutar

### 1. Habilitar ejecucion de scripts (una sola vez)

Abrir PowerShell como Administrador y ejecutar:

```powershell
Set-ExecutionPolicy RemoteSigned
```

Confirmar con `S` cuando lo solicite.

### 2. Desbloquear el archivo (si fue descargado de internet)

```powershell
Unblock-File -Path .\script03.ps1
```

### 3. Ejecutar el script

Navegar a la carpeta donde esta el script y ejecutar:

```powershell
.\script03.ps1
```


## Que hace el script

1. Crea los grupos locales: `Administracion`, `Soporte`, `Docentes`
2. Crea los usuarios locales: `ana.admin`, `bruno.soporte`, `carla.docente`
3. Asigna cada usuario a su grupo correspondiente
4. Crea la estructura de carpetas en `C:\Empresa` (Administracion, Soporte, Docentes, Compartida)
5. Crea la carpeta `C:\Respaldos` si no existe
6. Copia `C:\Empresa` a `C:\Respaldos\Empresa` (si ya existe un respaldo previo, lo elimina y genera uno nuevo)

En cada paso el script informa si el elemento ya existe o si fue creado.

## Notas

- Si algun grupo, usuario o carpeta ya existe, el script lo omite sin generar errores.
- El respaldo siempre se sobreescribe con la version mas reciente.
- Cambiar la contrasena de los usuarios luego de la primera ejecucion.
