function MostrarMenu {
    Write-Host "***** UCU-Campus Salto || SO 2026 *****"
    Write-Host "---------- Menu Principal ----------"
    Write-Host "1. Ordenar lista."
    Write-Host "2. Repetir la palabra N veces."
    Write-Host "3. Listar usuarios locales del equipo."
    Write-Host "4. Salir"
    Write-Host "-------------------------------------------"
}

function OrdenarLista {
    $valores = @()
    for ($i = 1; $i -le 5; $i++) {
        $valores += [int](Read-Host "Ingrese el valor $i")
    }
    $ordenado = $valores | Sort-Object -Descending
    Write-Host "Valores ordenados de mayor a menor:"
    $ordenado | ForEach-Object { Write-Host $_ }
}

function RepetirPalabra {
    $palabra = Read-Host "Ingrese una palabra"
    do {
        $n = [int](Read-Host "Ingrese un valor (1-99)")
        if ($n -le 0 -or $n -ge 100) {
            Write-Host "El valor debe ser mayor a 0 y menor a 100."
        }
    } while ($n -le 0 -or $n -ge 100)

    for ($i = 1; $i -le $n; $i++) {
        Write-Host $palabra
    }
}

function ListarUsuarios {
    Write-Host "Usuarios locales del equipo:"
    Get-LocalUser | ForEach-Object { Write-Host $_.Name }
}

do {
    MostrarMenu
    $opcion = Read-Host "Ingrese una opcion"

    switch ($opcion) {
        "1" { OrdenarLista }
        "2" { RepetirPalabra }
        "3" { ListarUsuarios }
        "4" { Write-Host "Saliendo..." }
        default { Write-Host "Opcion invalida. Intente de nuevo." }
    }

} while ($opcion -ne "4")
