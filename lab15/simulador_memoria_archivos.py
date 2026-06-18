from pathlib import Path

MEMORIA_TOTAL = 100 * 1024  # 100 KB

memoria = []

def listar_archivos_en_disco():
    ruta = Path("archivos")

    if not ruta.exists() or not ruta.is_dir():
        print("Error: la carpeta 'archivos/' no existe.")
        return

    print("\nArchivos disponibles en disco:")
    hay_archivos = False

    for archivo in ruta.iterdir():
        if archivo.is_file():
            tamanio = archivo.stat().st_size
            kb_aprox = tamanio // 1024
            print(f"  - {archivo.name} | {tamanio} bytes | {kb_aprox} KB aprox.")
            hay_archivos = True

    if not hay_archivos:
        print("  No se encontraron archivos en la carpeta.")

def calcular_memoria_utilizada():
    total = 0
    for archivo in memoria:
        total += archivo["tamanio"]
    return total

def calcular_memoria_libre():
    return MEMORIA_TOTAL - calcular_memoria_utilizada()

def cargar_archivo():
    nombre = input("\nIngrese nombre del archivo a cargar: ")
    ruta_completa = Path("archivos") / nombre

    if not ruta_completa.exists():
        print(f"Error: el archivo '{nombre}' no existe en disco.")
        return

    for archivo in memoria:
        if archivo["nombre"] == nombre:
            print(f"Error: el archivo '{nombre}' ya esta cargado en memoria.")
            return

    tamanio = ruta_completa.stat().st_size
    libre = calcular_memoria_libre()

    if tamanio > libre:
        print("No hay memoria suficiente para cargar el archivo.")
        print(f"Memoria disponible: {libre} bytes")
        print(f"Tamanio del archivo: {tamanio} bytes")
        return

    memoria.append({"nombre": nombre, "tamanio": tamanio})
    print("Archivo cargado correctamente en memoria.")

def liberar_archivo():
    nombre = input("\nIngrese nombre del archivo a liberar: ")

    for i, archivo in enumerate(memoria):
        if archivo["nombre"] == nombre:
            memoria.pop(i)
            print("Archivo liberado correctamente.")
            return

    print(f"Error: el archivo '{nombre}' no esta cargado en memoria.")

def ver_estado_memoria():
    usada = calcular_memoria_utilizada()
    libre = calcular_memoria_libre()
    porcentaje = (usada / MEMORIA_TOTAL) * 100

    print("\n===== ESTADO DE MEMORIA =====")
    print(f"Memoria total:      {MEMORIA_TOTAL} bytes")
    print(f"Memoria utilizada:  {usada} bytes")
    print(f"Memoria libre:      {libre} bytes")
    print(f"Uso de memoria:     {porcentaje:.2f} %")

    print("\nArchivos cargados:")
    if not memoria:
        print("  (ninguno)")
    else:
        for archivo in memoria:
            print(f"  - {archivo['nombre']} | {archivo['tamanio']} bytes")

def main():
    opcion = 0

    while opcion != 5:
        print("\n===== SIMULADOR DE MEMORIA Y ARCHIVOS =====")
        print("1. Listar archivos disponibles en disco")
        print("2. Cargar archivo en memoria")
        print("3. Liberar archivo de memoria")
        print("4. Ver estado de la memoria")
        print("5. Salir")
        opcion = int(input("Seleccione una opcion: "))

        if opcion == 1:
            listar_archivos_en_disco()
        elif opcion == 2:
            cargar_archivo()
        elif opcion == 3:
            liberar_archivo()
        elif opcion == 4:
            ver_estado_memoria()
        elif opcion == 5:
            print("Saliendo del simulador...")
        else:
            print("Opcion invalida. Intente nuevamente.")

main()
