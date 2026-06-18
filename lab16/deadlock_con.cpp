#include <iostream>
#include <thread>
#include <mutex>
#include <chrono>

using namespace std;

mutex recursoA;
mutex recursoB;

void proceso1()
{
    cout << "P1 intenta tomar Recurso A" << endl;
    recursoA.lock();
    cout << "P1 tomo Recurso A" << endl;

    this_thread::sleep_for(chrono::milliseconds(500));

    cout << "P1 intenta tomar Recurso B" << endl;
    recursoB.lock();
    cout << "P1 tomo Recurso B" << endl;

    recursoB.unlock();
    recursoA.unlock();
    cout << "P1 libero ambos recursos" << endl;
}

void proceso2()
{
    cout << "P2 intenta tomar Recurso B" << endl;
    recursoB.lock();
    cout << "P2 tomo Recurso B" << endl;

    this_thread::sleep_for(chrono::milliseconds(500));

    cout << "P2 intenta tomar Recurso A" << endl;
    recursoA.lock();
    cout << "P2 tomo Recurso A" << endl;

    recursoA.unlock();
    recursoB.unlock();
    cout << "P2 libero ambos recursos" << endl;
}

int main()
{
        cout << "SIMULACION CON DEADCK " << endl;
    cout << "P1 toma A luego B, P2 toma B luego A (orden inverso)" << endl;
    cout << endl;

    thread t1(proceso1);
    thread t2(proceso2);

    t1.join();
    t2.join();

    cout << endl;
    cout << "Fin del programa" << endl;
    return 0;
}
