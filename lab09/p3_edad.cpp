#include <iostream>
#include <string>
using namespace std;

int main() {
    string nombre;
    int edad;

    cout << "Ingrese su nombre: ";
    cin >> nombre;

    do {
        cout << "Ingrese su edad: ";
        cin >> edad;
        if (edad < 0) {
            cout << "La edad no puede ser negativa. Intente de nuevo." << endl;
        }
    } while (edad < 0);

    cout << "Hola " << nombre << "! ";
    if (edad >= 18) {
        cout << "Sos mayor de edad." << endl;
    } else {
        cout << "Sos menor de edad." << endl;
    }

    return 0;
}
