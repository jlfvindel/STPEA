# Libros ejecutables

Ejemplo guiado de producción de materiales docentes con [MyST](https://mystmd.org): cuadernos Jupyter en un libro MyST y opciones para que los estudiantes los ejecuten, con JupyterLite en el navegador.

Forma parte de una serie de cuatro proyectos independientes, pensados para recorrerse en orden:

1. Usar MyST y maquetar
2. Recursos multimedia
3. Reutilizar y enlazar
4. **Libros ejecutables** (este)

Cada proyecto está construido con el propio MyST: lo que explica está escrito con los recursos que explica.

## Ponerlo en marcha

1. Instala [Node.js](https://nodejs.org) (versión 22 o superior) y MyST: `npm install -g mystmd` (o `pip install mystmd`).
2. En una terminal, desde esta carpeta: `myst start`.
3. Abre <http://localhost:3000>.

Para ejecutar los cuadernos en el propio ordenador hace falta además Python con los paquetes de `requirements.txt` (y `jupyter-server`). Para publicar con JupyterLite, los de `requirements-lite.txt`; el guion `publicar.sh` construye el libro y JupyterLite juntos.

## Configuraciones

| Fichero | Se usa con | Qué produce |
|---|---|---|
| `myst.yml` | `myst start` | Libro con los resultados ya calculados |
| `myst-lite.yml` | `myst --config myst-lite.yml start` | Celdas ejecutables en el navegador (JupyterLite) |
| `myst-local.yml` | `myst --config myst-local.yml start` | Celdas ejecutables con un Jupyter local |

## Publicarlo

```bash
./preparar-descarga.sh                     # zip de la fuente, para el botón de descarga
BASE_URL=/ruta/del/sitio ./publicar.sh
```

y se copia el contenido de `_build/html` al servidor. Si no se ejecuta `preparar-descarga.sh`, MyST avisa de que falta el fichero de descarga; el resto del sitio funciona igual.

## Licencia y elaboración

José Luis Fernández Vindel. Contenido bajo licencia [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.es).

Preparado en colaboración con un asistente de inteligencia artificial (Claude, de Anthropic); el autor ha decidido el enfoque, ha revisado el resultado y responde de su contenido. Comprobado con MyST 1.13.0.
