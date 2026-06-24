# Laboratorio 17
Estudiante: Silva, Ignacio

Universidad Católica

Asignatura: Sistemas Operativos

Docente: Jorge Martínez

Fecha: 23 de junio de 2026


## Simulador de solicitudes de I/O (`simulador_io.cpp`)

El programa simula un sistema operativo atendiendo solicitudes de lectura y escritura generadas por varios procesos. Tiene 3 hilos productores que representan procesos y 1 hilo consumidor que representa el driver del dispositivo.

Cada productor genera entre 3 y 5 solicitudes aleatorias (lectura o escritura sobre distintos archivos) con pausas entre medio para simular tiempos reales. Las solicitudes se meten en una cola compartida protegida con `mutex` y `condition_variable`. El consumidor las va sacando en orden de llegada, simula el tiempo que tarda el dispositivo en atenderlas y las registra en un archivo `io_log.txt`.

La estructura `SolicitudIO` tiene el id del proceso, tipo de operación, archivo destino y tiempo estimado de atención.


### Cómo se relaciona con el SO

Los 3 productores y el consumidor corren como hilos con `std::thread`, y el planificador del SO decide el orden de ejecución, por eso el resultado cambia entre corridas. La cola compartida vive en RAM y se protege con `mutex` para que no se corrompa cuando varios hilos intentan acceder al mismo tiempo. El `condition_variable` hace que el consumidor se duerma cuando no hay solicitudes en vez de estar preguntando en un loop infinito, ahorrando CPU. El log en disco con `ofstream` representa la persistencia en el sistema de archivos. Y el `sleep_for` simula el tiempo real que tardaría un dispositivo lento en completar una operación de I/O.


### Ejecución

![Ejecución del simulador](assets/sc01.png)


### Observaciones

Sin el mutex, los hilos podrían leer y modificar la cola al mismo tiempo y los datos se corromperían. El consumidor funciona como un driver: recibe solicitudes, las procesa de a una y confirma la operación. Cuando todos los productores terminan y la cola queda vacía, el consumidor se cierra limpiamente.
