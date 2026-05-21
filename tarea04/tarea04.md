# Tarea 04
Estudiante: Silva, Ignacio

Universidad Católica

Asignatura: Sistemas Operativos 

Docente: Jorge Martínez

Fecha: 21 de mayo de 2026

# Disclaimer
Para los precios de componentes tomé como referencia el mercado uruguayo usando MercadoLibre Uruguay y algunos distribuidores locales. Los valores son aproximados al momento de redactar este documento y pueden variar. Para los servicios cloud los precios están en dólares ya que así los publican los proveedores, con la conversión aproximada a pesos uruguayos al cambio del momento (~$41 por dólar).


# Creación de modelos 3D, Realidad Virtual y Aumentada

1. Procesador: AMD Ryzen 9 7950X (16 núcleos, 4.5GHz base) =~$58.000 UYU
2. GPU: NVIDIA RTX 4090 24GB =~$195.000 UYU (componente más crítico de este setup)
3. RAM: 64GB DDR5 =~$28.000 UYU
4. Almacenamiento: 2TB NVMe SSD =~$20.000 UYU
5. Costo total estimado del equipo: =$330.000 UYU

## Justificación
Para este contexto lo que más importa es la GPU. El modelado 3D, los motores de VR y las herramientas de AR (Blender, Unreal, Unity) dependen enormemente de la capacidad de renderizado en tiempo real. La RTX 4090 tiene 16.384 núcleos CUDA y soporte nativo para ray tracing acelerado por hardware, lo que reduce los tiempos de render de horas a minutos.
El Ryzen 9 7950X con 16 núcleos complementa bien esto ya que Blender y los simuladores de física distribuyen bien la carga entre todos los núcleos cuando se trabaja con render por CPU también.
64GB de RAM entiendo que es el mínimo razonable para escenas complejas. Con menos se empieza a notar lag cuando se tienen muchos assets cargados en simultáneo.

## Backup

### RAID 5
3x HDD 4TB (Seagate IronWolf, pensados para uso continuo) en RAID 5 con controladora por software (Storage Spaces en Windows o mdadm en Linux). Esto da 8TB útiles con tolerancia a falla de un disco.
Costo aproximado: ~$8.000 UYU por disco × 3 =~$24.000 UYU

### Cloud
Google Drive for Business (Google Workspace Business Standard): USD 12/usuario/mes (~$516 UYU/mes)
Lo elijo porque los archivos de proyectos 3D y VR son enormes y Google Drive integra bien con el flujo de trabajo colaborativo. El plan Business Standard da 2TB por usuario y tiene buen rendimiento de subida. Para un equipo pequeño de 2-3 personas es razonable económicamente.


# Desarrollo para Consolas de Videojuegos

1. Procesador: AMD Ryzen 9 7900X (12 núcleos, 4.7GHz base) =~$45.000 UYU
2. GPU: NVIDIA RTX 4080 Super 16GB =~$130.000 UYU
3. RAM: 64GB DDR5 =~$28.000 UYU
4. Almacenamiento: 4TB NVMe SSD =~$38.000 UYU (los builds de juegos consumen mucho espacio)
5. Costo total estimado del equipo: =~$280.000 UYU

## Justificación
El desarrollo para consolas tiene una particularidad: hay que compilar y testear builds completos del juego constantemente. Eso implica muchos núcleos de CPU trabajando al mismo tiempo y mucho almacenamiento rápido para no esperar horas cada vez que se compila.
La GPU sigue siendo importante porque se trabaja con motores como Unreal o Unity que requieren buena capacidad gráfica para el editor, pero no necesita ser tan tope de gama como en el caso anterior. Una RTX 4080 Super cubre bien sin ser exagerado.
Los 4TB de NVMe son clave. Un proyecto en Unreal con assets de alta resolución fácilmente supera el TB, y tener el almacenamiento rápido reduce el tiempo de carga del editor significativamente.
Vale aclarar que los dev kits (PlayStation Dev Kit, Xbox Developer Kit) los provee directamente Sony o Microsoft y no entran en este presupuesto.

## Backup

### RAID 5
3x SSD 2TB (Samsung 870 EVO o similar) en RAID 5. Se usa SSD en lugar de HDD porque los builds frecuentes necesitan velocidades de escritura altas y un HDD sería un cuello de botella.
Costo aproximado: ~$14.000 UYU por disco × 3 = ~$42.000 UYU

### Cloud
Microsoft Azure Blob Storage (Cool tier) =USD 0,01/GB/mes
Para un equipo de desarrollo es una buena opción porque se integra con Azure DevOps que muchas desarrolladoras ya usan para CI/CD. El tier "Cool" está pensado para datos que se acceden poco (backups) y es más barato que el tier estándar. Para 5TB de builds almacenados el costo ronda los ~USD 50/mes (~$2.150 UYU/mes).


# Análisis y Modelos para Predicción Meteorológica

1. Procesador: AMD Threadripper PRO 5955WX (16 núcleos, hasta 4.5GHz) =~$135.000 UYU
2. GPU: NVIDIA RTX A4000 16GB (pensada para cómputo científico con CUDA) =~$105.000 UYU
3. RAM: 256GB DDR4 ECC =~$110.000 UYU
4. Almacenamiento: 4TB NVMe SSD =~$38.000 UYU
5. Costo total estimado del equipo: =~$460.000 UYU

## Justificación
Las simulaciones climáticas son un caso donde la RAM manda. Los modelos meteorológicos trabajan con grillas tridimensionales de la atmósfera que pueden representar millones de puntos de datos simultáneamente. Con poca RAM el modelo simplemente no corre, o se ve forzado a paginar datos al disco y ahí el tiempo de ejecución se va a semanas.
El Threadripper PRO tiene soporte para memorias ECC (Error Correcting Code), que corrigen errores de bit automáticamente. Eso es importante en cálculos científicos donde un bit mal puede arruinar días de simulación sin que nadie se dé cuenta.
La A4000 no es para gráficos sino para acelerar el cómputo paralelo con CUDA. Herramientas como WRF (Weather Research and Forecasting Model) pueden aprovechar esto.
Para simulaciones que excedan la capacidad local, la integración con cloud (Azure o AWS) para escalar el cómputo es lo que hacen organizaciones como el Met Office del Reino Unido, que ya mencioné en la tarea anterior.

## Backup

### RAID 5
3x HDD 8TB (Seagate IronWolf Pro) en RAID 5. Los datos meteorológicos históricos son enormes, entonces acá se prioriza capacidad sobre velocidad.
Costo aproximado: ~$15.000 UYU por disco × 3 = ~$45.000 UYU

### Cloud
Amazon S3 (Glacier Instant Retrieval) = USD 0,004/GB/mes
AWS Glacier está diseñado exactamente para esto: archivos que se guardan y raramente se acceden, como series históricas de simulaciones. Para 10TB de datos el costo es ~USD 40/mes (~$1.720 UYU/mes). Además AWS tiene integración nativa con herramientas de HPC científico como AWS Batch, por si se escala el procesamiento a la nube.


# Servidor Web (Aplicaciones y Sitios)

1. Procesador: Intel Xeon E-2324G (4 núcleos, 3.1GHz) = ~$30.000 UYU
2. RAM: 32GB DDR4 ECC = ~$22.000 UYU
3. Almacenamiento: 2x 1TB SSD (en RAID 1 para el OS) + pool RAID 5 aparte = ~$18.000 UYU
4. Placa de red: 10GbE = ~$8.000 UYU
5. Costo total estimado del equipo: =~$115.000 UYU

## Justificación
Un servidor web no necesita una GPU potente ni una cantidad exagerada de núcleos. Lo que necesita es responder muchas requests concurrentes de forma confiable. El Xeon E-2324G es un procesador de servidor de gama de entrada que cumple bien este rol y tiene soporte para ECC, lo que reduce el riesgo de corrupción de datos en memoria.
32GB de RAM es suficiente para la mayoría de aplicaciones web con tráfico moderado. Si se trata de una aplicación con mucho caching en memoria (Redis, Memcached) habría que escalar a 64GB, pero como punto de partida está bien.
La tarjeta 10GbE vale la pena para no hacer cuello de botella en la red cuando hay picos de tráfico.

## Backup

### RAID 5
3x SSD 1TB para los archivos del sitio y la aplicación en RAID 5. Da 2TB útiles con redundancia. El OS vive en un RAID 1 aparte con dos discos dedicados para que si falla uno el servidor no se caiga.
Costo aproximado: ~$9.000 UYU por disco × 3 = ~$27.000 UYU

### Cloud
Backblaze B2 = USD 0,006/GB/mes
Para un servidor web el backup en cloud no necesita ser sofisticado ni caro. Backblaze B2 es la opción más económica del mercado para almacenamiento de objetos y tiene una API compatible con S3, lo que facilita la integración con herramientas de backup estándar como restic o rclone. Para 500GB de backups el costo es ~USD 3/mes (~$130 UYU/mes).


# Servidor de Base de Datos

1. Procesador: AMD EPYC 7313 (16 núcleos, 3.0GHz) = ~$95.000 UYU
2. RAM: 256GB DDR4 ECC = ~$110.000 UYU
3. Almacenamiento: 4x NVMe SSD 2TB en RAID 5 = ~$80.000 UYU
4. Costo total estimado del equipo: ~$360.000 UYU

## Justificación
Las bases de datos son el caso donde la RAM es lo más importante de todo. Los motores como PostgreSQL o MySQL cargan índices y datos frecuentes en memoria para no ir al disco constantemente. Cuanta más RAM, menos lecturas de disco, y eso se traduce directamente en queries más rápidas.
El EPYC 7313 de AMD es interesante porque tiene soporte para grandes cantidades de memoria y canales de memoria de alta velocidad, lo que le viene bien a un servidor de base de datos que está leyendo y escribiendo en RAM todo el tiempo.
El almacenamiento en NVMe es clave acá también. Cuando sí hay que ir al disco (escrituras, queries pesadas) la diferencia entre un HDD y un NVMe es de varios órdenes de magnitud en IOPS. Para una base de datos eso importa mucho.

## Backup

### RAID 5
4x NVMe 2TB en RAID 5 (en este caso los discos del storage son los mismos que conforman el array). Da 6TB útiles con tolerancia a falla de un disco. Se usa controladora hardware (Broadcom MegaRAID) para no quitarle CPU al motor de base de datos.
Costo controladora: ~$20.000 UYU. Discos ya incluidos en el costo del equipo. Costo adicional: ~$20.000 UYU

### Cloud
Amazon RDS Backup / AWS S3 = USD 0,023/GB/mes para S3 estándar
Para bases de datos el backup en cloud tiene que ser confiable y con buena velocidad de restauración. S3 estándar (no Glacier) permite recuperar datos rápido en caso de desastre. Si se usa PostgreSQL o MySQL, herramientas como pg_dump o mysqldump generan archivos que se pueden subir automáticamente a S3 con scripts programados. Para 2TB de dumps mensuales el costo es ~USD 46/mes (~$1.980 UYU/mes).
