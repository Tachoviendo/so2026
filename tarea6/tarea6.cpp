#include <iostream>
#include <thread>
#include <mutex>
#include <chrono>
#include <cstdlib>

using namespace std;

mutex cafetera;

void estudianteTomaCafe(int id) {
    for (int i = 0; i < 2; i++) {

        // espera un tiempo random antes de querer cafe (entre 0.5 y 2 seg) me ayuda con gemini para esta linea jiji
        this_thread::sleep_for(chrono::milliseconds(rand() % 1500 + 500));

        cout << "Estudiante " << id << " quiere cafe." << endl;
        cout << "Estudiante " << id << " espera para entrar a la cocina..." << endl;

        cafetera.lock();   // si alguien esta adentro queda bloqueada la cagetera. 

        cout << "Estudiante " << id << " entra a la cocina." << endl;

        this_thread::sleep_for(chrono::milliseconds(rand() % 2000 + 1000)); //simula que esta haciendo algo complejo. 

        cout << "Estudiante " << id << " sale de la cocina." << endl;

        cafetera.unlock(); // libera la cafetera para el siguiente
    }
}

int main() {
    srand(42);

    cout << "Cafeteria UCU " << endl;
    cout << "5 estudiantes, 2 cafes cada uno." << endl << endl;

    // Pongo los hilos todos a la vez y es al funcion que va a calcular un tiempo random para ver cual es el que va a querer un cafe primero. 
    thread t1(estudianteTomaCafe, 1);
    thread t2(estudianteTomaCafe, 2);
    thread t3(estudianteTomaCafe, 3);
    thread t4(estudianteTomaCafe, 4);
    thread t5(estudianteTomaCafe, 5);
    
    t1.join();
    t2.join();
    t3.join();
    t4.join();
    t5.join();

    cout << "\nTodos los estudiantes tomaron su cafe." << endl;
    return 0;
}
