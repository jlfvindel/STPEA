# STPEA · Soporte Tecnológico a Procesos de Enseñanza y Aprendizaje

Sitio de la asignatura (planificación y teoría), hecho con [MyST](https://mystmd.org). Se organiza en tres bloques:

1. Gestión de espacios de aprendizaje propios
2. Producción de contenidos y actividades
3. Tutorización de cursos

Forma parte del repositorio de la asignatura: los ejemplos del bloque 2 están en la carpeta hermana `../ejemplos-myst/`, cada uno como proyecto MyST independiente. En el servidor, cada edición del curso tiene esta forma:

```text
<edición>/
├── index.html        portada de la edición
├── stpea-curso/      este sitio
└── ejemplos-myst/    índice y un subdirectorio por ejemplo
```

## Ponerlo en marcha

1. Instala [Node.js](https://nodejs.org) (versión 22 o superior) y MyST: `npm install -g mystmd`.
2. Desde esta carpeta: `myst start`, y abre <http://localhost:3000>.

En local, los enlaces a `/ejemplos-myst/…` no llevan a ningún sitio: los ejemplos solo existen en el servidor.

## Publicarlo

```bash
BASE_URL=/ruta/del/curso/stpea-curso ./publicar.sh
```

y se copia el contenido de `_build/html` a la carpeta `stpea-curso/` del servidor. Lo normal es no hacerlo a mano: `construir-arbol.sh`, en la raíz del repositorio, construye toda la asignatura.

Las páginas enlazan los ejemplos como `/ejemplos-myst/…`. MyST interpreta cualquier ruta (también `../…`) dentro del propio sitio, así que el script crea en `_build/html/ejemplos-myst/` unas páginas mínimas que redirigen a la carpeta hermana `../ejemplos-myst/…` con rutas relativas: una para el índice y otra por cada carpeta de `../ejemplos-myst/` que tenga `myst.yml`. Un ejemplo nuevo tiene su redirección sin hacer nada. Ninguna dirección del servidor queda escrita en el proyecto.

## Licencia

José Luis Fernández Vindel. Contenido bajo licencia [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.es). Preparado con la ayuda de un asistente de inteligencia artificial (Claude, de Anthropic); el autor responde de su contenido.
