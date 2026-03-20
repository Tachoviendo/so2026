# Tarea 02
Estudiante: Silva, Ignacio

Universidad Católica

Asignatura: Sistemas Operativos 

Docente: Jorge Martínez

Fecha: 19 de marzo de 2026

# Disclaimer 
Para esta tarea, dada la cantidad de proveedores y la dificultad de discernir cual de ellos es legítimo o no, voy a tomar todos los precios de la web de eneba.com

# Cibercafe
1. Windows 
2. Licencia Windows pro OEM (https://www.eneba.com/latam/microsoft-windows-microsoft-windows-11-oem-professional-key-global)

## Justificación 
Al ser un cibercafe, el cliente promedio es un usuario que necesita usar windows y el paquete office, conectarse a internet y demás prestaciones. No suele ser un usuario técnico que necesite herramientras fuera del sistema operativo antes mencionado. 
A los costos podríamos incluir una licencia de Microsoft 365 que, para 6 usuarios, ronda los 5000 pesos al año (Precio del mercado europeo ya que en eneba la oferta global se encuentra agotada).

# Laboratorio de Informática
1. Linux Ubuntu 24.04 LTS
2. Licencia gratuita (Open Source)
3. Servidor educativo: Dell PowerEdge T150
   - Procesador: Intel Xeon E-2314 (4 núcleos, 2.8GHz)
   - RAM: 16GB DDR4
   - Almacenamiento: 2TB HDD
   - Costo aproximado: USD 800-1000 (según configuración)
   - link de compra por Mercadolibre: (https://www.mercadolibre.com.uy/servidor-dell-emc-poweredge-t150-xeon-e-2324g-16-gb-hd4-tb/p/MLU32553913)

## Justificación
Al ser un laboratorio de informática educativo, los usuarios son estudiantes que necesitan aprender sobre sistemas operativos, programación y herramientas de desarrollo. Ubuntu entiendo que es ideal porque es gratuito, es una distro estable que no tiene mayor dificultad en su instalación  y permite a los estudiantes familiarizarse con entornos linux que son ampliamente utilizados en el ámbito profesional.
La arquitectura cliente-servidor permite gestionar centralmente las actualizaciones y el software instalado. El servidor Dell PowerEdge T150 es una opción económica y confiable para un entorno educativo, permitiendo servicios como autenticación centralizada, almacenamiento compartido y gestión de usuarios.
Los costos de mantenimiento son significativamente menores al no requerir licencias, solo personal capacitado para administración del sistemaque entiendo serían los propios profesores o estudiantes.

# Sala de Testing para Videojuegos Online
1. Windows 11 Pro
2. Licencia Windows Pro OEM (https://www.eneba.com/latam/microsoft-windows-microsoft-windows-11-oem-professional-key-global)

## Justificación
Al ser una sala de testing para videojuegos online, es fundamental testear en el mismo entorno que usa la mayoría de los usuarios finales y los mismos se encuentran, en su gran mayoría en windows. Los juegos están optimizados para este sistema operativo y muchas desarrolladoras buscan la maxima compatibilidad con ordenadores que corran windows. Esta tendencia está cambiando gracias a anuncios de Steam con su videoconsola portatil que usa SteamOS una distro para jugar integraada con sus servicios. 
En cuanto al hardware, necesitamos equipos decentes con buenas placas de video (NVIDIA/AMD), procesadores modernos y suficiente RAM para ejecutar los juegos en condiciones reales de uso. Esto es crucial para detectar problemas de rendimiento, bugs gráficos y otros issues que puedan aparecer durante el testing.

# Laboratorio de Simulaciones de Eventos Climáticos
1. Rocky Linux 9 
2. Licencia gratuita (Open Source)
3. Servidor de cálculo: Dell PowerEdge R750
   - Procesador: Dual Intel Xeon Gold 6338 (64 cores totales)
   - RAM: 256GB DDR4 ECC
   - Almacenamiento: 8TB SSD RAID
   - Costo aproximado: USD 8000-12000
4. Integración con servicios cloud (Microsoft Azure) para procesamiento distribuido
5. Referencia: Met Office UK (https://www.youtube.com/watch?v=J7hvHslfS5A)

## Justificación
Al ser un laboratorio de simulaciones climáticas, necesitamos un sistema operativo robusto y optimizado para computación científica de alto rendimiento. Rocky Linux es ideal porque es gratuito, compatible con RHEL (una distro de Red hat paga para estos casos)  y ampliamente utilizado en investigación científica. Organizaciones como el Met Office del Reino Unido usan sistemas basados en Linux con integración cloud para sus modelos climáticos complejos.
Las simulaciones climáticas requieren procesamiento paralelo intensivo, por lo que la arquitectura cliente-servidor es fundamental. Las estaciones de trabajo preparan los modelos y visualizan resultados, mientras que el servidor de cálculo ejecuta las simulaciones con múltiples cores trabajando en paralelo.
La integración con Azure les permite escalar el procesamiento cuando las simulaciones lo requieran, sin necesidad de invertir en hardware adicional permanente. Esto es especialmente útil para modelos climáticos que pueden tardar días o semanas en ejecutarse.

# Monitoreo y Administración de un Datacenter
1. Ubuntu Server 24.04 LTS
2. Licencia gratuita (Open Source)
3. Servidor de monitoreo: Dell PowerEdge R450
   - Procesador: Intel Xeon Silver 4310 (12 cores)
   - RAM: 64GB DDR4 ECC
   - Almacenamiento: 4TB SSD RAID
   - Costo aproximado: USD 3000-4000
4. Stack de monitoreo: Zabbix + Prometheus + Grafana (todas herramientas gratuitas)

## Justificación
Para monitoreo y administración de un datacenter necesitamos un sistema operativo extremadamente estable, confiable y que funcione 24/7 sin interrupciones. Ubuntu Server LTS es ideal porque ofrece 5 años de soporte, es gratuito y tiene compatibilidad nativa con las mejores herramientas de monitoreo del mercado.
El stack Zabbix/Prometheus/Grafana permite monitorear toda la infraestructura del datacenter: servidores, switches, almacenamiento, temperatura, consumo eléctrico, etc. Grafana ofrece dashboards visuales en tiempo real y Prometheus maneja métricas de alto rendimiento. Todo esto sin costo de licencias.
La arquitectura cliente-servidor permite que el servidor de monitoreo recopile datos de todos los equipos del datacenter y genere alertas automáticas ante cualquier problema (servidor caído, temperatura alta, disco lleno, etc.).

### glosario de herramientas que no conocia
- **Zabbix**: Sistema de monitoreo empresarial que recopila datos de servidores, switches y otros dispositivos de red. Envía alertas por email/SMS cuando detecta problemas.
- **Prometheus**: Base de datos especializada en almacenar métricas de rendimiento (CPU, RAM, red, etc.) con capacidad de consulta rápida para análisis histórico.
- **Grafana**: Plataforma de visualización que crea dashboards interactivos y gráficos en tiempo real a partir de los datos recopilados por Prometheus y Zabbix.


