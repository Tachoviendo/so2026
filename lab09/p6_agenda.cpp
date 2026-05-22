#include <iostream>
#include <string>
using namespace std;

struct Actividad {
    string fecha;
    string hora;
    string descripcion;
    Actividad* siguiente; // puntero al siguiente nodo
};

void registrar(Actividad*& cabeza) {
    Actividad* nueva = new Actividad();
    cout << "Fecha (dd/mm/aaaa): ";
    cin >> nueva->fecha;
    cout << "Hora (hh:mm): ";
    cin >> nueva->hora;
    cin.ignore();
    cout << "Descripcion: ";
    getline(cin, nueva->descripcion);
    nueva->siguiente = nullptr;

    if (cabeza == nullptr) {
        cabeza = nueva;
    } else {
        Actividad* actual = cabeza;
        while (actual->siguiente != nullptr) {
            actual = actual->siguiente;
        }
        actual->siguiente = nueva;
    }
    cout << "Actividad registrada." << endl;
}

void mostrar(Actividad* cabeza) {
    if (cabeza == nullptr) {
        cout << "No hay actividades registradas." << endl;
        return;
    }
    int i = 1;
    Actividad* actual = cabeza;
    while (actual != nullptr) {
        cout << i++ << ". " << actual->fecha << " " << actual->hora << " - " << actual->descripcion << endl;
        actual = actual->siguiente;
    }
}

void modificar(Actividad* cabeza) {
    if (cabeza == nullptr) {
        cout << "No hay actividades para modificar." << endl;
        return;
    }
    mostrar(cabeza);
    int n;
    cout << "Numero a modificar: ";
    cin >> n;

    Actividad* actual = cabeza;
    for (int i = 1; i < n && actual != nullptr; i++) {
        actual = actual->siguiente;
    }

    if (actual == nullptr) {
        cout << "Numero invalido." << endl;
        return;
    }

    cout << "Nueva fecha: ";
    cin >> actual->fecha;
    cout << "Nueva hora: ";
    cin >> actual->hora;
    cin.ignore();
    cout << "Nueva descripcion: ";
    getline(cin, actual->descripcion);
    cout << "Actividad modificada." << endl;
}

void eliminar(Actividad*& cabeza) {
    if (cabeza == nullptr) {
        cout << "No hay actividades para eliminar." << endl;
        return;
    }
    mostrar(cabeza);
    int n;
    cout << "Numero a eliminar: ";
    cin >> n;

    if (n == 1) {
        Actividad* temp = cabeza;
        cabeza = cabeza->siguiente;
        delete temp;
        cout << "Actividad eliminada." << endl;
        return;
    }

    Actividad* actual = cabeza;
    for (int i = 1; i < n - 1 && actual->siguiente != nullptr; i++) {
        actual = actual->siguiente;
    }

    if (actual->siguiente == nullptr) {
        cout << "Numero invalido." << endl;
        return;
    }

    Actividad* temp = actual->siguiente;
    actual->siguiente = temp->siguiente;
    delete temp;
    cout << "Actividad eliminada." << endl;
}

int main() {
    Actividad* cabeza = nullptr;
    int opcion;

    do {
        cout << "\n--- Agenda ---" << endl;
        cout << "1. Registrar actividad" << endl;
        cout << "2. Mostrar actividades" << endl;
        cout << "3. Modificar actividad" << endl;
        cout << "4. Eliminar actividad" << endl;
        cout << "5. Salir" << endl;
        cout << "Opcion: ";
        cin >> opcion;

        switch (opcion) {
            case 1: registrar(cabeza); break;
            case 2: mostrar(cabeza); break;
            case 3: modificar(cabeza); break;
            case 4: eliminar(cabeza); break;
            case 5: cout << "Saliendo..." << endl; break;
            default: cout << "Opcion invalida." << endl;
        }
    } while (opcion != 5);

    while (cabeza != nullptr) {
        Actividad* temp = cabeza;
        cabeza = cabeza->siguiente;
        delete temp;
    }

    return 0;
}
