# Laboratorio 10
Estudiante: Silva, Ignacio

Universidad Católica

Asignatura: Sistemas Operativos 

Docente: Jorge Martínez

Fecha: 21 de mayo de 2026


## Pensar la solución

El objetivo es imprimir "SALTO" 6 veces usando un hilo por letra. El problema es que los hilos corren en paralelo y sin coordinación van a imprimir las letras en cualquier orden. Para resolverlo uso una variable `turno` compartida que indica qué letra tiene que imprimir en cada momento. Cada hilo espera hasta que `turno` coincida con su posición, imprime su letra y avanza el turno.

Para esto necesito tres cosas de la librería estándar de C++:
- `<thread>` para crear los hilos
- `<mutex>` para proteger el acceso a `turno`
- `<condition_variable>` para que los hilos esperen su turno sin consumir CPU innecesariamente


## La función de cada hilo

Cada hilo recibe su letra y su posición en la palabra. Espera a que `turno` sea igual a su posición, imprime, incrementa el turno y avisa al resto.

```cpp
void imprimirLetra(char letra, int posicion, int totalLetras) {
    unique_lock<mutex> lock(mtx);
    cv.wait(lock, [&] { return turno == posicion; });
    cout << letra;
    turno++;
    if (turno == totalLetras) {
        cout << endl;
    }
    cv.notify_all();
}
```

El `cv.wait` libera el mutex mientras espera, lo que permite que los otros hilos también entren y queden esperando. Cuando uno imprime su letra y llama a `notify_all`, todos se despiertan y el que tenga el turno correcto continúa.


## El main

```cpp
int main() {
    string palabra = "SALTO";
    int repeticiones = 6;

    for (int i = 0; i < repeticiones; i++) {
        turno = 0;
        vector<thread> hilos;

        for (int j = 0; j < (int)palabra.size(); j++) {
            hilos.emplace_back(imprimirLetra, palabra[j], j, (int)palabra.size());
        }

        for (auto& h : hilos) {
            h.join();
        }
    }

    return 0;
}
```

Por cada repetición reinicio `turno` a 0 y creo 5 hilos, uno por letra. El `join` al final asegura que la palabra esté completa antes de pasar a la siguiente.


## Compilación y ejecución

```bash
g++ -std=c++11 -pthread -o lab10 lab10.cpp
./lab10
```


## Resultado

![output](assets/sc01.png)
