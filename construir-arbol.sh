#!/bin/sh
# Prepara en publicar/ el árbol completo que se sube al servidor.
#
#   BASE_RAIZ=/ruta/de/la/asignatura ./construir-arbol.sh
#
# BASE_RAIZ es la ruta (sin barra final) que corresponde en el servidor
# a la raíz de este repositorio. No se guarda en ningún fichero.
#
# - Ficheros estáticos (index.html, imágenes…): se copian tal cual.
#   Solo los que están en git, así no se cuela nada local.
# - Cada carpeta con myst.yml es un proyecto MyST: se construye con
#   BASE_URL=$BASE_RAIZ/<su ruta> y se copia solo su _build/html.
#   Si el proyecto tiene preparar-descarga.sh, se ejecuta antes;
#   si tiene publicar.sh, se usa en lugar de «myst build --html».
set -e
: "${BASE_RAIZ:?Indica la ruta de la raíz, p. ej. BASE_RAIZ=/ruta/de/la/asignatura ./construir-arbol.sh}"
cd "$(dirname "$0")"
RAIZ=$(pwd)
SALIDA="$RAIZ/publicar"
rm -rf "$SALIDA"
mkdir -p "$SALIDA"

# Proyectos MyST: carpetas en git que contienen un myst.yml
PROYECTOS=$(git ls-files | grep '\(^\|/\)myst\.yml$' | sed 's|/\{0,1\}myst\.yml$||' | sort)

dentro_de_proyecto() {
  for p in $PROYECTOS; do
    case "$1" in "$p"/*) return 0 ;; esac
  done
  return 1
}

# 1. Ficheros estáticos
git ls-files | while IFS= read -r f; do
  case "$f" in construir-arbol.sh|.gitignore|README.md) continue ;; esac
  dentro_de_proyecto "$f" && continue
  mkdir -p "$SALIDA/$(dirname "$f")"
  cp "$f" "$SALIDA/$f"
done

# 2. Proyectos MyST
for p in $PROYECTOS; do
  echo "== $p  (BASE_URL=$BASE_RAIZ/$p)"
  (
    cd "$RAIZ/$p"
    export BASE_URL="$BASE_RAIZ/$p"
    [ -x preparar-descarga.sh ] && ./preparar-descarga.sh
    if [ -x publicar.sh ]; then ./publicar.sh; else myst build --html; fi
  )
  mkdir -p "$SALIDA/$p"
  cp -R "$RAIZ/$p/_build/html/." "$SALIDA/$p/"
done

echo
echo "Árbol listo en publicar/. Para empaquetarlo:"
echo "  tar -czf asignatura.tar.gz -C publicar .     (o: cd publicar && zip -r ../asignatura.zip .)"
