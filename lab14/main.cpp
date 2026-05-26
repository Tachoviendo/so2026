#include <cstdio>
#include <iostream>
#include <string>
#include <fstream>
#include <unistd.h>
#include <sys/syscall.h>
#include <signal.h>
using namespace std;


int buscarPorNombre(const string& name) {
    string comando = "pgrep " + name;
    FILE* pipe = popen(comando.c_str(), "r");
    if (!pipe) return -1;

    char result[128];
    fgets(result, 128, pipe);
    pclose(pipe);

    return atoi(result);
}


string obtenerNombre(int pid) {
    string comando = "cat /proc/" + to_string(pid) + "/comm";
    FILE* pipe = popen(comando.c_str(), "r");
    if (!pipe) return "desconocido";

    char result[128];
    fgets(result, 128, pipe);
    pclose(pipe);

    string nombre = result;
    if (!nombre.empty() && nombre.back() == '\n')
        nombre.pop_back();

    return nombre;
}


string obtenerEstado(int pid, int tid) {
    string comando = "grep State /proc/" + to_string(pid) + "/task/" + to_string(tid) + "/status";
    FILE* pipe = popen(comando.c_str(), "r");
    if (!pipe) return "desconocido";

    char result[128];
    fgets(result, 128, pipe);
    pclose(pipe);

    string estado = result;
    if (!estado.empty() && estado.back() == '\n')
        estado.pop_back();

    return estado;
}


void listarHilos(int pid) {
    string nombre = obtenerNombre(pid);

    cout << "Proceso: " << nombre << endl;
    cout << "PID: " << pid << endl;
    cout << "TID\tEstado" << endl;

    string archivoNombre = "proceso_" + to_string(pid) + ".txt";
    ofstream archivo(archivoNombre);
    archivo << "Proceso: " << nombre << "\n";
    archivo << "PID: " << pid << "\n";
    archivo << "TID\tEstado\n";

    string comando = "ls /proc/" + to_string(pid) + "/task/";
    FILE* pipe = popen(comando.c_str(), "r");
    if (!pipe) return;

    char result[128];
    while (fgets(result, 128, pipe) != nullptr) {
        int tid = atoi(result);
        string estado = obtenerEstado(pid, tid);

        cout << tid << "\t" << estado << endl;
        archivo << tid << "\t" << estado << "\n";
    }

    pclose(pipe);
    archivo.close();

    cout << "Exportado a: " << archivoNombre << endl;
}


void terminarHilo(int pid, int tid) {
    int resultado = syscall(SYS_tgkill, pid, tid, SIGKILL);

    if (resultado == 0) {
        cout << "El hilo " << tid << " ha sido terminado con exito." << endl;
    } else {
        cout << "Error al terminar el hilo " << tid << "." << endl;
    }
}


int main() {
    int opcion;
    string nombre;
    int pid = -1;

    cout << "1. Buscar por nombre" << endl;
    cout << "2. Buscar por PID" << endl;
    cout << "Opcion: ";
    cin >> opcion;
    cin.ignore();

    if (opcion == 1) {
        cout << "Nombre del proceso: ";
        getline(cin, nombre);
        pid = buscarPorNombre(nombre);

    } else if (opcion == 2) {
        cout << "PID: ";
        cin >> pid;

    } else {
        cout << "Opcion invalida" << endl;
        return 1;
    }

    if (pid <= 0) {
        cout << "Proceso no encontrado." << endl;
        return 1;
    }

    listarHilos(pid);

    cout << "Terminar algun hilo? (s/n): ";
    char resp;
    cin >> resp;

    if (resp == 's' || resp == 'S') {
        cout << "TID a terminar: ";
        int tid;
        cin >> tid;
        terminarHilo(pid, tid);
    }

    return 0;
}
