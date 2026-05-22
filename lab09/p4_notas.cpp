#include <iostream>
using namespace std;

int main() {
    int nota;

    cout << "Ingrese la nota (0-100): ";
    cin >> nota;

    if (nota < 0 || nota > 100) {
        cout << "Nota fuera de rango." << endl;
    } else if (nota >= 75) {
        cout << "Excelente" << endl;
    } else if (nota >= 25) {
        cout << "Aprobado" << endl;
    } else {
        cout << "No Aprobado" << endl;
    }

    return 0;
}
