#include <stdio.h>
#include <stdlib.h>

int archivoExiste(const char* path) {
    FILE* f = fopen(path, "r");
    if (f == NULL) {
        return 0;
    }
    fclose(f);
    return 1;
}

int main() {
    int opcion;

    while (1) {
        printf("ACME   \n");
        printf(" 1. Ejecutar script Linux     \n");
        printf(" 2. Ejecutar script Windows   \n");
        printf(" 3. Automatico (detectar SO)  \n");
        printf(" 4. Salir                     \n");
        printf("Opcion: ");
        scanf("%d", &opcion);

        if (opcion == 1) {
            if (!archivoExiste("./gestion_lx.sh")) {
                printf("ERROR: No se encontro gestion_lx.sh\n");
            } else {
                system("sudo bash ./gestion_lx.sh");
            }

        } else if (opcion == 2) {
            if (!archivoExiste("./gestion_win.ps1")) {
                printf("ERROR: No se encontro gestion_win.ps1\n");
            } else {
                system("powershell -ExecutionPolicy Bypass -File ./gestion_win.ps1");
            }

        } else if (opcion == 3) {
            printf("en proceso!\n");
        } else if (opcion == 4) {
            printf("Saliendo...\n");
            return 0;

        } else {
            printf("Opcion invalida.\n");
        }
    }
}
