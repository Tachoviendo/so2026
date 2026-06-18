import java.nio.file.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class SimuladorMemoriaArchivos
{
    static final long MEMORIA_TOTAL = 100 * 1024; // 100 KB

    static ArrayList<String[]> memoria = new ArrayList<>();

    static Scanner scanner = new Scanner(System.in);

    public static void listarArchivosEnDisco()
    {
        Path ruta = Paths.get("archivos");

        if (!Files.exists(ruta) || !Files.isDirectory(ruta))
        {
            System.out.println("Error: la carpeta 'archivos/' no existe.");
            return;
        }

        System.out.println("\nArchivos disponibles en disco:");
        boolean hayArchivos = false;

        try (DirectoryStream<Path> stream = Files.newDirectoryStream(ruta))
        {
            for (Path entrada : stream)
            {
                if (Files.isRegularFile(entrada))
                {
                    String nombre = entrada.getFileName().toString();
                    long tamanio = Files.size(entrada);
                    long kbAprox = tamanio / 1024;
                    System.out.println("  - " + nombre + " | " + tamanio + " bytes | " + kbAprox + " KB aprox.");
                    hayArchivos = true;
                }
            }
        }
        catch (IOException e)
        {
            System.out.println("Error al leer la carpeta: " + e.getMessage());
            return;
        }

        if (!hayArchivos)
        {
            System.out.println("  No se encontraron archivos en la carpeta.");
        }
    }

    public static long calcularMemoriaUtilizada()
    {
        long total = 0;
        for (String[] archivo : memoria)
        {
            total += Long.parseLong(archivo[1]);
        }
        return total;
    }

    public static long calcularMemoriaLibre()
    {
        return MEMORIA_TOTAL - calcularMemoriaUtilizada();
    }

    public static void cargarArchivo()
    {
        System.out.print("\nIngrese nombre del archivo a cargar: ");
        String nombre = scanner.nextLine();

        Path rutaCompleta = Paths.get("archivos", nombre);

        if (!Files.exists(rutaCompleta))
        {
            System.out.println("Error: el archivo '" + nombre + "' no existe en disco.");
            return;
        }

        for (String[] archivo : memoria)
        {
            if (archivo[0].equals(nombre))
            {
                System.out.println("Error: el archivo '" + nombre + "' ya esta cargado en memoria.");
                return;
            }
        }

        long tamanio;
        try
        {
            tamanio = Files.size(rutaCompleta);
        }
        catch (IOException e)
        {
            System.out.println("Error al leer el archivo: " + e.getMessage());
            return;
        }

        long libre = calcularMemoriaLibre();

        if (tamanio > libre)
        {
            System.out.println("No hay memoria suficiente para cargar el archivo.");
            System.out.println("Memoria disponible: " + libre + " bytes");
            System.out.println("Tamanio del archivo: " + tamanio + " bytes");
            return;
        }

        memoria.add(new String[]{nombre, String.valueOf(tamanio)});
        System.out.println("Archivo cargado correctamente en memoria.");
    }

    public static void liberarArchivo()
    {
        System.out.print("\nIngrese nombre del archivo a liberar: ");
        String nombre = scanner.nextLine();

        for (int i = 0; i < memoria.size(); i++)
        {
            if (memoria.get(i)[0].equals(nombre))
            {
                memoria.remove(i);
                System.out.println("Archivo liberado correctamente.");
                return;
            }
        }

        System.out.println("Error: el archivo '" + nombre + "' no esta cargado en memoria.");
    }

    public static void verEstadoMemoria()
    {
        long usada = calcularMemoriaUtilizada();
        long libre = calcularMemoriaLibre();
        double porcentaje = ((double) usada / MEMORIA_TOTAL) * 100.0;

        System.out.println("\n===== ESTADO DE MEMORIA =====");
        System.out.println("Memoria total:      " + MEMORIA_TOTAL + " bytes");
        System.out.println("Memoria utilizada:  " + usada + " bytes");
        System.out.println("Memoria libre:      " + libre + " bytes");
        System.out.printf("Uso de memoria:     %.2f %%\n", porcentaje);

        System.out.println("\nArchivos cargados:");
        if (memoria.isEmpty())
        {
            System.out.println("  (ninguno)");
        }
        else
        {
            for (String[] archivo : memoria)
            {
                System.out.println("  - " + archivo[0] + " | " + archivo[1] + " bytes");
            }
        }
    }

    public static void main(String[] args)
    {
        int opcion = 0;

        do
        {
            System.out.println("\n===== SIMULADOR DE MEMORIA Y ARCHIVOS =====");
            System.out.println("1. Listar archivos disponibles en disco");
            System.out.println("2. Cargar archivo en memoria");
            System.out.println("3. Liberar archivo de memoria");
            System.out.println("4. Ver estado de la memoria");
            System.out.println("5. Salir");
            System.out.print("Seleccione una opcion: ");
            opcion = Integer.parseInt(scanner.nextLine());

            switch (opcion)
            {
                case 1:
                    listarArchivosEnDisco();
                    break;
                case 2:
                    cargarArchivo();
                    break;
                case 3:
                    liberarArchivo();
                    break;
                case 4:
                    verEstadoMemoria();
                    break;
                case 5:
                    System.out.println("Saliendo del simulador...");
                    break;
                default:
                    System.out.println("Opcion invalida. Intente nuevamente.");
                    break;
            }
        } while (opcion != 5);
    }
}
