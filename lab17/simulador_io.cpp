#include <iostream>
#include <fstream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <queue>
#include <string>
#include <chrono>
#include <cstdlib>
#include <ctime>

using namespace std;

struct SolicitudIO
{
    int idProceso;
    string tipoOperacion;
    string archivoDestino;
    int tiempoEstimado;
};

queue<SolicitudIO> colaSolicitudes;
mutex mtx;
condition_variable cv;
int productoresActivos = 3;

void productor(int idProceso)
{
    string tipos[] = {"lectura", "escritura"};
    string archivos[] = {"datos.txt", "config.log", "reporte.csv", "backup.bin"};
    int cantidadSolicitudes = 3 + rand() % 3;

    for (int i = 0; i < cantidadSolicitudes; i++)
    {
        int tiempoEspera = 300 + rand() % 700;
        this_thread::sleep_for(chrono::milliseconds(tiempoEspera));

        SolicitudIO solicitud;
        solicitud.idProceso = idProceso;
        solicitud.tipoOperacion = tipos[rand() % 2];
        solicitud.archivoDestino = archivos[rand() % 4];
        solicitud.tiempoEstimado = 200 + rand() % 500;

        {
            lock_guard<mutex> lock(mtx);
            colaSolicitudes.push(solicitud);
            cout << "[Proceso " << idProceso << "] Genera solicitud de "
                 << solicitud.tipoOperacion << " sobre " << solicitud.archivoDestino << endl;
        }

        cv.notify_one();
    }

    {
        lock_guard<mutex> lock(mtx);
        productoresActivos--;
        cout << "[Proceso " << idProceso << "] Finalizo (" << productoresActivos << " activos)" << endl;
    }

    cv.notify_one();
}

void consumidor()
{
    ofstream log("io_log.txt");
    int atendidas = 0;

    while (true)
    {
        unique_lock<mutex> lock(mtx);
        cv.wait(lock, []{ return !colaSolicitudes.empty() || productoresActivos == 0; });

        if (colaSolicitudes.empty() && productoresActivos == 0)
        {
            break;
        }

        SolicitudIO solicitud = colaSolicitudes.front();
        colaSolicitudes.pop();
        lock.unlock();

        this_thread::sleep_for(chrono::milliseconds(solicitud.tiempoEstimado));

        atendidas++;
        cout << "[Driver] Atendio " << solicitud.tipoOperacion
             << " de Proceso " << solicitud.idProceso
             << " sobre " << solicitud.archivoDestino
             << " (" << solicitud.tiempoEstimado << "ms)" << endl;

        log << "Solicitud #" << atendidas
            << " | Proceso: " << solicitud.idProceso
            << " | Operacion: " << solicitud.tipoOperacion
            << " | Archivo: " << solicitud.archivoDestino
            << " | Tiempo: " << solicitud.tiempoEstimado << "ms" << endl;
    }

    log.close();
    cout << "\n[Driver] Total de solicitudes atendidas: " << atendidas << endl;
    cout << "[Driver] Log guardado en io_log.txt" << endl;
}

int main()
{
    srand(time(nullptr));

    cout << "=== SIMULADOR DE SOLICITUDES DE I/O ===" << endl;
    cout << "3 procesos productores | 1 driver consumidor" << endl;
    cout << endl;

    thread t1(productor, 1);
    thread t2(productor, 2);
    thread t3(productor, 3);
    thread tDriver(consumidor);

    t1.join();
    t2.join();
    t3.join();
    tDriver.join();

    cout << "\nFin de la simulacion." << endl;
    return 0;
}
