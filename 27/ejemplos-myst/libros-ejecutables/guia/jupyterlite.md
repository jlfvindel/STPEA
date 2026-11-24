---
title: JupyterLite en el servidor de la institución
short_title: JupyterLite institucional
label: jupyterlite-institucional
---

Esta página describe la configuración más completa para una institución que ya dispone de un servidor web (por ejemplo, Apache): publicar en él **el libro** y, junto a él, **un JupyterLab completo** que funciona en el navegador, con los cuadernos ya cargados. El servidor solo entrega ficheros; el cálculo lo hace el ordenador de cada estudiante.

## Qué se publica

Todo cabe en una carpeta:

```text
_build/html/                      ← se copia entera al servidor
├── index.html, …                 el libro (myst-lite.yml): celdas ejecutables en la página
└── lite/                         JupyterLite
    ├── lab/index.html            interfaz JupyterLab
    ├── notebooks/index.html      interfaz sencilla, de un solo cuaderno
    └── files/trayectorias.ipynb  los cuadernos que se ofrecen
```

El libro sirve para leer y experimentar celda a celda. JupyterLite ofrece el entorno de trabajo completo: crear cuadernos nuevos, guardar, descargar, abrir una consola de Python…

## Construirlo

Quien publica necesita, además de MyST, los paquetes de `requirements-lite.txt`:

```bash
pip install -r requirements-lite.txt
```

El guion `publicar.sh` hace las dos construcciones seguidas:

:::{literalinclude} ../publicar.sh
:language: bash
:::

`jupyter lite build` crea el sitio JupyterLite. `--contents` indica qué ficheros se ofrecen al estudiante (se puede repetir, o indicar una carpeta entera), y `--output-dir` dónde se genera. Al generarlo dentro de `_build/html`, el libro y JupyterLite se publican juntos.

:::{note} Solo cuadernos `.ipynb`
JupyterLite abre los `.ipynb` como cuadernos. Un cuaderno de texto `.md` lo abriría como un documento de texto, así que aquí solo se incluye `trayectorias.ipynb`.
:::

## Publicarlo en Apache

Se copia el contenido de `_build/html` en la carpeta del servidor, como cualquier sitio estático (el proyecto 1 lo explica con detalle). Si el sitio va en una subcarpeta, se construye con su ruta:

```bash
BASE_URL=/ruta/del/libro ./publicar.sh
```

Para el servidor no hay nada más que configurar: no ejecuta nada, solo entrega ficheros. Dos recomendaciones:

- **Usar HTTPS.** JupyterLite usa un *service worker*, un componente que los navegadores solo permiten en páginas seguras (HTTPS) o en `localhost`. Sin él, algunas funciones, como el acceso desde el código a los ficheros del estudiante, no están disponibles.
- **Probarlo antes en local**, con un servidor sencillo:

  ```bash
  cd _build/html
  python -m http.server 8000
  ```

  y abriendo <http://localhost:8000/lite/lab/index.html>.

## Enlazar un cuaderno desde el libro

Cada cuaderno tiene una dirección propia en JupyterLite. Con el sitio publicado en `https://servidor.ejemplo/ruta/del/libro/`, el cuaderno de trayectorias se abre en:

```text
https://servidor.ejemplo/ruta/del/libro/lite/lab/index.html?path=trayectorias.ipynb
```

o, con la interfaz sencilla de un solo cuaderno:

```text
https://servidor.ejemplo/ruta/del/libro/lite/notebooks/index.html?path=trayectorias.ipynb
```

Esa dirección se pone como un enlace normal en cualquier página del libro, o en el aula virtual:

```markdown
[Abrir el cuaderno en JupyterLite](https://servidor.ejemplo/ruta/del/libro/lite/lab/index.html?path=trayectorias.ipynb)
```

Dentro del propio libro basta la ruta desde su raíz, sin servidor: MyST le añade la ruta base al construir. Así está escrito este enlace, que funciona en el libro publicado con `publicar.sh`:

```markdown
[Abrir el cuaderno de trayectorias en JupyterLite](/lite/lab/index.html?path=trayectorias.ipynb)
```

Resultado: [Abrir el cuaderno de trayectorias en JupyterLite](/lite/lab/index.html?path=trayectorias.ipynb)

Con `myst start` el enlace no lleva a nada, porque JupyterLite solo existe en la versión construida.

## Lo que ve el estudiante

1. Al abrir el enlace, el navegador descarga JupyterLab y, al ejecutar la primera celda, Python. La primera vez tarda unos segundos; después, el navegador lo guarda en caché.
2. Trabaja como en cualquier JupyterLab: edita, ejecuta, crea cuadernos nuevos.
3. Lo que guarda se queda en el almacenamiento de **su navegador**, en ese ordenador. Si cambia de equipo o borra los datos de navegación, no lo encontrará. Para entregar o conservar su trabajo, lo descarga (*File › Download*).

## Sin depender de servidores externos

Por defecto, el sitio JupyterLite está en el servidor de la institución, pero Python (la distribución Pyodide) se descarga de un servidor público de distribución de software (jsDelivr), y al arrancar el núcleo se instalan además algunos paquetes pequeños desde PyPI, el repositorio público de paquetes de Python. Las celdas ejecutables dentro de las páginas del libro descargan también algunas piezas de unpkg. Si el aula no tiene internet, o la institución no quiere depender de un servicio externo, se puede alojar Pyodide en el propio servidor. La documentación de JupyterLite explica cómo: se descarga la distribución completa (varios cientos de megas), se copia al servidor, y se indica su dirección en el fichero `jupyter-lite.json` con la opción `pyodideUrl`.

En ese caso, conviene que Apache entregue los ficheros `.wasm` con su tipo correcto. Si no lo hace por defecto, basta una línea en su configuración (o en un `.htaccess`):

```apache
AddType application/wasm .wasm
```

:::{tip} Para explorar más
- Documentación de JupyterLite: <https://jupyterlite.readthedocs.io>. El apartado *Using a custom Pyodide distribution* explica cómo alojar Pyodide en el propio servidor.
- `jupyter lite build --help` muestra todas las opciones de construcción.
- Las celdas del libro (`myst-lite.yml`) y JupyterLite usan versiones distintas de Pyodide, y por tanto de Python y de sus paquetes. Si un cuaderno depende de una versión concreta de un paquete, conviene comprobarlo en los dos.
:::
