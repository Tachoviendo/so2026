# Laboratorio 05
Estudiante: Silva, Ignacio

Universidad Católica

Asignatura: Sistemas Operativos 

Docente: Jorge Martínez

Fecha: 21 de abril de 2026

# Expresiones regulares y sus aplicaciones. 

## 1. Qué son las expresiones regulares

Una expresión regular (también llamada *regex* o *regexp*) es un patrón que define un conjunto de cadenas de texto que lo satisfacen. Según Microsoft Learn, *"una expresión regular es un patrón que el motor de expresiones regulares intenta hacer coincidir en el texto de entrada; dicho patrón consiste en uno o más literales de caracteres, operadores o construcciones"* 

En otras palabras, una `regex` describe una estructura de texto mediante una sintaxis compacta. El motor de regex toma ese patrón y lo compara contra una cadena de entrada para verificar si hay coincidencia, extraer partes, o reemplazar contenido.

**Fuentes:**

- [1] Microsoft Learn – *Regular Expression Language - Quick Reference (.NET)*: https://learn.microsoft.com/en-us/dotnet/standard/base-types/regular-expression-language-quick-reference



## 2. Sintaxis y patrones de texto

Las expresiones regulares se construyen combinando distintos tipos de elementos sintácticos por lo que considero uportuno armar una tabla para clasificarlos a todos! (además quiero probar hacer una tabla en un `archivo.md`)

### 2.1 Clases de caracteres

Definen qué tipo de carácter debe coincidir en una posición determinada.

| Sintaxis | Descripción | Ejemplo |
|----------|-------------|---------|
| `[abc]` | Coincide con 'a', 'b' o 'c' | `/[aeiou]/` → encuentra vocales en `"hola"` |
| `[^abc]` | Coincide con cualquier carácter que NO sea 'a', 'b' ni 'c' | `/[^0-9]/` → encuentra todo lo que no es dígito en `"abc123"` |
| `[a-z]` | Rango: cualquier letra minúscula | `/[a-z]+/` → captura `"hola"` en `"hola MUNDO"` |
| `.` | Cualquier carácter excepto salto de línea | `/h.la/` → coincide con `"hola"`, `"hxla"`, `"h1la"` |
| `\d` | Dígito (equivale a `[0-9]`) | `/\d\d\d/` → encuentra `"123"` en `"abc123"` |
| `\w` | Carácter de palabra (letras, dígitos, guion bajo) | `/\w+/` → captura `"user_01"` completo |
| `\s` | Espacio en blanco (espacio, tabulación, salto de línea) | `/hola\smundo/` → coincide con `"hola mundo"` |

Empleando esta sintaxis es que podemos darle órdenes de manera imperativa. 
### 2.2 Anclas

Al leerlo, no pude evitar recordar los famososo `comodines` aunque muy alejada está su función a la de las `anclas`. Estas últimas indican una posición en el texto, no un carácter. Sirven para ubicarnos en la cadena. 

| Sintaxis | Descripción |
|----------|-------------|
| `^` | Inicio de la cadena |
| `$` | Fin de la cadena |
| `\b` | Límite de palabra |
| `\B` | NO es límite de palabra |

A diferencia de las clases de caracteres, las anclas no consumen caracteres: solo verifican una posición. Por eso se las llama *aserciones de ancho cero*.

#### Algunos ejemplos
1. `/^Hola/`. Coincide con cualquier cadena que empiece con `"Hola"`.
    - (ok) `"Hola mundo"`
    - (mal) `"Decir Hola"`

2. `/^\d{2}\/\d{2}\/\d{4}$/`. Valida que la cadena completa tenga formato de fecha `DD/MM/AAAA`. El `^` y `$` aseguran que no haya nada antes ni después.
    - (ok) `"21/04/2026"`
    - (mal) `"Fecha: 21/04/2026"`

3. `/\bruby\b/i`. Encuentra la palabra `"ruby"` como palabra completa (no como parte de otra). `\b` marca límites, `i` ignora mayúsculas.
    - (ok) `"Me gusta ruby"`)]}
    -(ok) `"Ruby es genial"`
    - (mal) `"Rubyshista!"` (no coincide porque `\b` detecta que no hay límite después de `python`)

### 2.3 Cuantificadores
Por otro lado, existen los `cuantificadores` que nos ayudan a especificar cuántas veces debe repetirse el elemento anterior.

| Sintaxis | Descripción |
|----------|-------------|
| `*` | 0 o más veces |
| `+` | 1 o más veces |
| `?` | 0 o 1 vez (opcional) |
| `{n}` | Exactamente n veces |
| `{n,m}` | Entre n y m veces |

Ejemplo: `/\d{3}-\d{4}/` coincide con un número tipo `123-4567`.

### 2.4 Grupos
Los `grupos` son una herramienta muy poderosa ya que permiten agrupar partes del patrón y capturar coincidencias.

| Sintaxis | Descripción |
|----------|-------------|
| `(x)` | Grupo de captura |
| `(?:x)` | Grupo sin captura |
| `(?<nombre>x)` | Grupo de captura con nombre |

Para entender esto más a fondo. planteo la siguiente problemática:  
`extraer día, mes y año de una fecha.`

```
/^(\d{2})\/(\d{2})\/(\d{4})$/
```

Aplicado sobre `"21/04/2026"`:

- `(\d{2})` : **Grupo 1** captura `"21"` (día)
- `\/` : coincide con la barra literal `/`
- `(\d{2})` : **Grupo 2** captura `"04"` (mes)
- `\/` : otra barra literal
- `(\d{4})` :Grupo 3 captura `"2026"` (año)

El resultado es un array: `["21/04/2026", "21", "04", "2026"]`. Cada grupo entre paréntesis se accede por índice numérico.

Con grupos nombrados queda más legible:

```
/^(?<dia>\d{2})\/(?<mes>\d{2})\/(?<anio>\d{4})$/
```

Ahora se accede como `match.groups.dia`, `match.groups.mes`, `match.groups.anio` en vez de índices.

### 2.5 Flags (modificadores)

Se agregan al final del patrón y modifican su comportamiento global.

| Flag | Descripción |
|------|-------------|
| `g` | Búsqueda global (todas las coincidencias) |
| `i` | Sin distinción entre mayúsculas y minúsculas |
| `m` | Multilínea (`^` y `$` aplican por línea) |

Ejemplo: `/hola/gi` encuentra todas las ocurrencias de "hola" sin importar mayúsculas.

**Fuente:** MDN Web Docs – *Regular expressions Cheatsheet*: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_expressions/Cheatsheet



## 3. Aplicaciones de uso de las RegEx

Por lo poco que he podido ver en mi breve investigación en clase tienen aplicaciones concretas en múltiples áreas del desarrollo de software y administración de sistemas. me dedique a urgar en varias páginas y ver ejemplos en los que veo una implementación práctica y entienda el porque se implementa una `regex` y no otra cosa. 

### 3.1 Validación de datos de entrada

Una de las aplicaciones que más sonadas son es la validar que un dato ingresado por el usuario tenga el formato esperado antes de procesarlo o almacenarlo.

```javascript
const re = /^(?:\d{3}|\(\d{3}\))([-/.])\d{3}\1\d{4}$/;
```

Desglose del patrón:
- `^` → inicio de la cadena
- `(?:\d{3}|\(\d{3}\))` → código de área: 3 dígitos solos o entre paréntesis
- `([-/.])` → separador capturado (guion, barra o punto)
- `\d{3}` → 3 dígitos centrales
- `\1` → backreference: el mismo separador de antes
- `\d{4}$` → 4 dígitos finales

Coincide con: `555-123-4567`, `(555).123.4567`
No coincide con: `5551234567`, `555-123/4567` (separadores distintos)

Fuente: [MDN Web Docs – Regular expressions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_expressions)

### 3.2 Detección de patrones sensibles en políticas de seguridad

Microsoft Purview DLP (Data Loss Prevention) usa regex para identificar y clasificar información sensible en correos y documentos corporativos.

Del mismo microsoft encontré un ejemplo bastante sencillo pero poderoso a la vez. el problema es bloquear emails cuyo asunto empiece con "ABC" seguido de un número** *(extraído de Microsoft Learn)*
```
^ABC\d
```

Aplicado en una regla DLP de PowerShell:
```powershell
New-DlpComplianceRule -Name "Rule_00" -Policy "Policy_00" `
  -SubjectOrBodyMatchesPatterns "^ABC\d" -BlockAccess $True
```

`^` ancla al inicio del texto extraído, `ABC` literal, `\d` cualquier dígito. Si el asunto es `"ABC123 - Reporte"`, la regla bloquea el envío.

Fuente: [Microsoft Learn – Using regex in DLP policies](https://learn.microsoft.com/en-us/purview/dlp-policy-learn-about-regex-use)

### 3.3 Extracción de información de texto no estructurado

Las `regex` permiten extraer fragmentos específicos de logs, respuestas de APIs o archivos de texto plano. Aunque lo considero una forma poco intuitiva de tratar estos tipos de output. 

```
/\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/g
```

Aplicado sobre una cadena del estilo: :
```
[2026-04-21] Conexión desde 192.168.1.10 rechazada
[2026-04-21] Acceso de 10.0.0.5 autorizado
```

Retorna: `["192.168.1.10", "10.0.0.5"]`

- `\b` → límites de palabra para no capturar números parciales
- `\d{1,3}` → entre 1 y 3 dígitos por octeto
- `\.` → punto literal (escapado)
- `g` → flag global, todas las coincidencias

Este tipo de extracción es base para herramientas de monitoreo de red y análisis de seguridad.

## 4. Patrón de texto para búsqueda de emails

### El patrón

Patrón extraído de la documentación oficial de Microsoft Learn (.NET):

```
^[^@\s]+@[^@\s]+\.[^@\s]+$
```

### Desglose sección por sección

Tabla de desglose según Microsoft Learn:

| Sección | Qué hace | Output |
|---------|----------|--------|
| `^` | Ancla al inicio de la cadena |  |
| `[^@\s]+` | Uno o más caracteres que NO sean `@` ni espacios en blanco | username |
| `@` | El símbolo `@` literal |  |
| `[^@\s]+` | Uno o más caracteres que NO sean `@` ni espacios en blanco | ve el dominio |
| `\.` | Un punto literal (escapado) | Separador entre dominio y la extensión |
| `[^@\s]+` | Uno o más caracteres que NO sean `@` ni espacios en blanco | ve la extensión del dominio |
| `$` | Ancla al final de la cadena | fin |

> **Nota de Microsoft:** *"Esta expresión regular no está pensada para cubrir todos los aspectos de una dirección de email válida. Se provee como ejemplo para extender según necesidad."*

**Fuente:** [Microsoft Learn – How to verify that strings are in valid email format (.NET)](https://learn.microsoft.com/en-us/dotnet/standard/base-types/how-to-verify-that-strings-are-in-valid-email-format)

### Ejemplos

| Cadena | Resultado |
|--------|-----------|
| `usuario@gmail.com` | (ok) coincide |
| `nombre.apellido@empresa.com.ar` | (ok) coincide |
| `sinArroba.com` | (x) no coincide (falta `@`) |
| `usuario @gmail.com` | (x) no coincide (espacio en parte local) |
| `usuario@@gmail.com` | (x) no coincide (doble `@`) |
| `usuario@` | (x) no coincide (falta dominio y TLD) |

### Lo que retorna

En .NET, usando `Regex.IsMatch()` con este patrón:
- `true` si la cadena tiene estructura válida de email
- `false` si no la tiene

```csharp
Regex.IsMatch(email,
    @"^[^@\s]+@[^@\s]+\.[^@\s]+$",
    RegexOptions.IgnoreCase, TimeSpan.FromMilliseconds(250));
```

Microsoft aclara que regex valida la estructura, no que el email exista realmente. Para eso recomienda enviar un email de prueba a la dirección.

## 5. Aplicaciones de RegEx en scripts de PowerShell

PowerShell soporta expresiones regulares de forma nativa mediante el operador `-match`, `-replace`, y la clase `[regex]` de .NET. Esto lo convierte en una herramienta poderosa para automatizar tareas de administración de sistemas.

### 5.1 Validar emails

> Script: [scripts/validar_emails.ps1](scripts/validar_emails.ps1)

**Escenario:** se tiene una lista de emails y se quiere saber cuáles tienen formato válido antes de usarlos.

El script lee el archivo [scripts/usuarios.csv](scripts/usuarios.csv) que contiene una columna `Email`:

```
Nombre,Email
Juan Pérez,juan.perez@empresa.com
Ana López,ana.lopez@
Carlos Ruiz,carlos@dominio.com.ar
Pedro,sindominio
```

```powershell
$patron = '^[^@\s]+@[^@\s]+\.[^@\s]+$'

Import-Csv -Path "$PSScriptRoot\usuarios.csv" | ForEach-Object {
    if ($_.Email -match $patron) {
        Write-Host "OK:    $($_.Email)"
    } else {
        Write-Host "ERROR: $($_.Email) - formato invalido"
    }
}
```

**Output esperado:**
```
OK:    juan.perez@empresa.com
ERROR: ana.lopez@ - formato invalido
OK:    carlos@dominio.com.ar
ERROR: sindominio - formato invalido
```

- `Import-Csv` lee el archivo y expone cada fila como objeto con propiedad `$_.Email`
- `-match` evalúa el string contra el patrón y retorna `$true` o `$false`
- `$PSScriptRoot` apunta a la carpeta del script, no al directorio de ejecución

---

### 5.2 Buscar IPs en un log

> Script: [scripts/buscar_ip_en_log.ps1](scripts/buscar_ip_en_log.ps1)

**Escenario:** se tiene un log del sistema y se quiere extraer todas las direcciones IP que aparecen en él.

```powershell
$patron = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'

$log = @(
    "[2026-04-21 08:00] Conexion desde 192.168.1.10 aceptada",
    "[2026-04-21 08:05] Intento fallido desde 10.0.0.5",
    "[2026-04-21 08:10] Sin actividad registrada",
    "[2026-04-21 08:15] Conexion desde 172.16.0.3 rechazada"
)

foreach ($linea in $log) {
    if ($linea -match $patron) {
        Write-Host "IP encontrada: $($matches[0])  |  Linea: $linea"
    }
}
```

**Output esperado:**
```
IP encontrada: 192.168.1.10  |  Linea: [2026-04-21 08:00] Conexion desde 192.168.1.10 aceptada
IP encontrada: 10.0.0.5      |  Linea: [2026-04-21 08:05] Intento fallido desde 10.0.0.5
IP encontrada: 172.16.0.3    |  Linea: [2026-04-21 08:15] Conexion desde 172.16.0.3 rechazada
```

**Desglose del patrón `\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b`:**

| Sección | Qué hace |
|---------|----------|
| `\b` | Límite de palabra — evita capturar números dentro de otro número |
| `\d{1,3}` | Entre 1 y 3 dígitos (un octeto de la IP) |
| `\.` | Punto literal separador |
| *(repetido ×4)* | Cubre los 4 octetos de una IPv4 |

- `$matches[0]` contiene la coincidencia completa (la IP encontrada)
- La línea sin IP no aparece en el output porque `-match` retorna `$false`
