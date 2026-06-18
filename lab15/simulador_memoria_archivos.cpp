#include <iostream>
#include <string>
#include <vector>
#include <filesystem>
#include <iomanip>

using namespace std;
namespace fs = std::filesystem;

struct ArchivoEnMemoria
{
    string nombre;
    size_t tamanio;
};

const size_t MEMORIA_TOTAL = 100 * 1024; // 100 KB

vector<ArchivoEnMemoria> memoria;

void listarArchivosEnDisco()
{
    string ruta = "archivos";

    if (!fs::exists(ruta) || !fs::is_directory(ruta))
    {
        cout << "Error: la carpeta 'archivos/' no existe." << endl;
        return;
    }

    cout << "\nArchivos disponibles en disco:" << endl;
    bool hayArchivos = false;

    for (const auto& entrada : fs::directory_iterator(ruta))
    {
        if (fs::is_regular_file(entrada))
        {
            string nombre = entrada.path().filename().string();
            size_t tamanio = fs::file_size(entrada);
            size_t kbAprox = tamanio / 1024;
            cout << "  - " << nombre << " | " << tamanio << " bytes | " << kbAprox << " KB aprox." << endl;
            hayArchivos = true;
        }
    }

    if (!hayArchivos)
    {
        cout << "  No se encontraron archivos en la carpeta." << endl;
    }
}

size_t calcularMemoriaUtilizada()
{
    size_t total = 0;
    for (const auto& archivo : memoria)
    {
        total += archivo.tamanio;
    }
    return total;
}

size_t calcularMemoriaLibre()
{
    return MEMORIA_TOTAL - calcularMemoriaUtilizada();
}

void cargarArchivo()
{
    string nombre;
    cout << "\nIngrese nombre del archivo a cargar: ";
    cin >> nombre;

    string rutaCompleta = "archivos/" + nombre;

    if (!fs::exists(rutaCompleta))
    {
        cout << "Error: el archivo '" << nombre << "' no existe en disco." << endl;
        return;
    }

    for (const auto& archivo : memoria)
    {
        if (archivo.nombre == nombre)
        {
            cout << "Error: el archivo '" << nombre << "' ya esta cargado en memoria." << endl;
            return;
        }
    }

    size_t tamanio = fs::file_size(rutaCompleta);
    size_t libre = calcularMemoriaLibre();

    if (tamanio > libre)
    {
        cout << "No hay memoria suficiente para cargar el archivo." << endl;
        cout << "Memoria disponible: " << libre << " bytes" << endl;
        cout << "Tamanio del archivo: " << tamanio << " bytes" << endl;
        return;
    }

    ArchivoEnMemoria nuevo;
    nuevo.nombre = nombre;
    nuevo.tamanio = tamanio;
    memoria.push_back(nuevo);

    cout << "Archivo cargado correctamente en memoria." << endl;
}

void liberarArchivo()
{
    string nombre;
    cout << "\nIngrese nombre del archivo a liberar: ";
    cin >> nombre;

    for (size_t i = 0; i < memoria.size(); i++)
    {
        if (memoria[i].nombre == nombre)
        {
            memoria.erase(memoria.begin() + i);
            cout << "Archivo liberado correctamente." << endl;
            return;
        }
    }

    cout << "Error: el archivo '" << nombre << "' no esta cargado en memoria." << endl;
}

void verEstadoMemoria()
{
    size_t usada = calcularMemoriaUtilizada();
    size_t libre = calcularMemoriaLibre();
    double porcentaje = (static_cast<double>(usada) / MEMORIA_TOTAL) * 100.0;

    cout << "\n===== ESTADO DE MEMORIA =====" << endl;
    cout << "Memoria total:      " << MEMORIA_TOTAL << " bytes" << endl;
    cout << "Memoria utilizada:  " << usada << " bytes" << endl;
    cout << "Memoria libre:      " << libre << " bytes" << endl;
    cout << "Uso de memoria:     " << fixed << setprecision(2) << porcentaje << " %" << endl;

    cout << "\nArchivos cargados:" << endl;
    if (memoria.empty())
    {
        cout << "  (ninguno)" << endl;
    }
    else
    {
        for (const auto& archivo : memoria)
        {
            cout << "  - " << archivo.nombre << " | " << archivo.tamanio << " bytes" << endl;
        }
    }
}

int main()
{
    int opcion;

    do
    {
        cout << "\n===== SIMULADOR DE MEMORIA Y ARCHIVOS =====" << endl;
        cout << "1. Listar archivos disponibles en disco" << endl;
        cout << "2. Cargar archivo en memoria" << endl;
        cout << "3. Liberar archivo de memoria" << endl;
        cout << "4. Ver estado de la memoria" << endl;
        cout << "5. Salir" << endl;
        cout << "Seleccione una opcion: ";
        cin >> opcion;

        switch (opcion)
        {
            case 1:
                listarArchivosEnDisco();
                break;
            case 2:
                cargarArchivo();
                break;
            case 3:
                liberarArchivo();
                break;
            case 4:
                verEstadoMemoria();
                break;
            case 5:
                cout << "Saliendo del simulador..." << endl;
                break;
            default:
                cout << "Opcion invalida. Intente nuevamente." << endl;
                break;
        }
    } while (opcion != 5);

    return 0;
}
