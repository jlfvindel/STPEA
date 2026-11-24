#!/bin/sh
# Construye el sitio para publicarlo en el servidor.
#
#   BASE_URL=/ruta/del/curso/stpea-curso ./publicar.sh
#
# (construir-arbol.sh, en la raíz del repositorio, lo llama con el
# BASE_URL adecuado; no hace falta ejecutarlo a mano.)
#
# Los ejemplos MyST no forman parte de este sitio: están en la carpeta
# hermana ../ejemplos-myst/. Las páginas los enlazan como /ejemplos-myst/…,
# y MyST convierte esas rutas en …/stpea-curso/ejemplos-myst/…
# Este script crea en esas rutas unas páginas mínimas de redirección
# hacia ../ejemplos-myst/…, con rutas relativas: una para el índice y
# otra por cada ejemplo (cada carpeta con myst.yml). Al añadir un
# ejemplo nuevo, su redirección aparece sola.
set -e
: "${BASE_URL:?Indica la ruta de publicación, p. ej. BASE_URL=/ruta/del/curso/stpea-curso ./publicar.sh}"
myst build --html

redireccion() {  # $1: ruta dentro de ejemplos-myst/ ("" o "nombre/"); $2: subida relativa
  destino="$2ejemplos-myst/$1"
  mkdir -p "_build/html/ejemplos-myst/$1"
  cat > "_build/html/ejemplos-myst/$1index.html" <<EOF
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
<title>Ejemplos MyST</title>
<meta http-equiv="refresh" content="0; url=$destino">
<meta name="robots" content="noindex">
</head>
<body><p>Los ejemplos están en <a href="$destino">$destino</a>.</p></body>
</html>
EOF
}

redireccion "" "../../"
for m in ../ejemplos-myst/*/myst.yml; do
  [ -f "$m" ] || continue
  redireccion "$(basename "$(dirname "$m")")/" "../../../"
done
echo "Sitio listo en _build/html (BASE_URL=$BASE_URL)"
