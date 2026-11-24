#!/bin/sh
# -------------------------------------------------------------
#  publicar.sh · Construye todo lo que se sube al servidor web
#
#  Uso:   ./publicar.sh                       (sitio en la raíz)
#         BASE_URL=/ruta/del/libro ./publicar.sh   (en una subcarpeta)
#
#  Resultado: la carpeta _build/html, lista para copiar al servidor.
#    _build/html/        el libro, con celdas ejecutables (myst-lite.yml)
#    _build/html/lite/   JupyterLite completo, con los cuadernos
# -------------------------------------------------------------
set -e

# 1. El libro MyST, con las celdas ejecutables en el navegador
myst --config myst-lite.yml build --html

# 2. JupyterLite, dentro de la carpeta del libro
jupyter lite build \
    --contents cuadernos/trayectorias.ipynb \
    --output-dir _build/html/lite

echo "Listo: copia el contenido de _build/html al servidor."
