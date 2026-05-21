#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <vector>
#include <string>

using namespace std;

mutex mtx;
condition_variable cv;
int turno = 0; // indica qué letra le toca imprimir

// cada hilo espera su turno antes de imprimir
void imprimirLetra(char letra, int posicion, int totalLetras) {
    unique_lock<mutex> lock(mtx);
    cv.wait(lock, [&] { return turno == posicion; });
    this_thread::sleep_for(chrono::seconds(2));
    cout << letra;
    turno++;
    if (turno == totalLetras) {
        cout << endl;
    }
    cv.notify_all(); // avisa al resto que el turno cambio
}

int main() {
    string palabra = "SALTO";
    int repeticiones = 6;

    for (int i = 0; i < repeticiones; i++) {
        turno = 0; // reinicio el turno para cada palabra
        vector<thread> hilos;

        // creo un hilo por cada letra
        for (int j = 0; j < (int)palabra.size(); j++) {
            hilos.emplace_back(imprimirLetra, palabra[j], j, (int)palabra.size());
        }

        // espero que todos terminen antes de pasar a la siguiente palabra
        for (auto& h : hilos) {
            h.join();
        }
    }

    return 0;
}
