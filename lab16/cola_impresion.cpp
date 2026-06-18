#include <iostream>
#include <vector>
#include <string>

using namespace std;

struct TrabajoImpresion
{
    int id;
    string nombreArchivo;
    int paginas;
};

int contadorId = 1;
vector<TrabajoImpresion> cola;

void agregarTrabajo()
{
    string nombre;
    int paginas;

    cout << "\nIngrese nombre del archivo: ";
    cin >> nombre;
    cout << "Ingrese cantidad de paginas: ";
    cin >> paginas;

    if (paginas <= 0)
    {
        cout << "Error: la cantidad de paginas debe ser mayor a cero." << endl;
        return;
    }

    TrabajoImpresion nuevo;
    nuevo.id = contadorId++;
    nuevo.nombreArchivo = nombre;
    nuevo.paginas = paginas;
    cola.push_back(nuevo);

    cout << "Trabajo agregado con ID " << nuevo.id << "." << endl;
}

void listarTrabajos()
{
    if (cola.empty())
    {
        cout << "\nNo hay trabajos pendientes." << endl;
        return;
    }

    cout << "\nTrabajos pendientes:" << endl;
    for (const auto& trabajo : cola)
    {
        cout << "  ID: " << trabajo.id
             << " | Archivo: " << trabajo.nombreArchivo
             << " | Paginas: " << trabajo.paginas << endl;
    }
}

void procesarSiguiente()
{
    if (cola.empty())
    {
        cout << "\nLa cola de impresion esta vacia." << endl;
        return;
    }

    TrabajoImpresion trabajo = cola.front();
    cola.erase(cola.begin());

    cout << "\nProcesando impresion de: " << trabajo.nombreArchivo
         << " (" << trabajo.paginas << " paginas)" << endl;
    cout << "Trabajo ID " << trabajo.id << " completado." << endl;
}

void cancelarTrabajo()
{
    int id;
    cout << "\nIngrese ID del trabajo a cancelar: ";
    cin >> id;

    for (size_t i = 0; i < cola.size(); i++)
    {
        if (cola[i].id == id)
        {
            cout << "Trabajo '" << cola[i].nombreArchivo << "' cancelado." << endl;
            cola.erase(cola.begin() + i);
            return;
        }
    }

    cout << "Error: no se encontro un trabajo con ID " << id << "." << endl;
}

void mostrarEstadisticas()
{
    cout << "\nESTADISTICAS DE LA COLA " << endl;
    cout << "Trabajos pendientes: " << cola.size() << endl;

    int totalPaginas = 0;
    for (const auto& trabajo : cola)
    {
        totalPaginas += trabajo.paginas;
    }

    cout << "Total de paginas en espera: " << totalPaginas << endl;
}

int main()
{
    int opcion;

    do
    {
        cout << "\n COLA DE IMPRESION " << endl;
        cout << "1. Agregar trabajo de impresion" << endl;
        cout << "2. Listar trabajos pendientes" << endl;
        cout << "3. Procesar siguiente trabajo" << endl;
        cout << "4. Cancelar trabajo por ID" << endl;
        cout << "5. Mostrar estadisticas" << endl;
        cout << "6. Salir" << endl;
        cout << "Seleccione una opcion: ";
        cin >> opcion;

        switch (opcion)
        {
            case 1:
                agregarTrabajo();
                break;
            case 2:
                listarTrabajos();
                break;
            case 3:
                procesarSiguiente();
                break;
            case 4:
                cancelarTrabajo();
                break;
            case 5:
                mostrarEstadisticas();
                break;
            case 6:
                cout << "Saliendo del sistema de impresion..." << endl;
                break;
            default:
                cout << "Opcion invalida." << endl;
                break;
        }
    } while (opcion != 6);

    return 0;
}
