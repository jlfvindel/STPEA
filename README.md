# STPEA · Soporte Tecnológico a Procesos de Enseñanza y Aprendizaje

Repositorio único con todo lo que se publica de la asignatura. Su estructura es la misma que la del servidor:

```text
stpea/                          raíz de la asignatura
├── index.html                  portada permanente: lista de ediciones
├── construir-arbol.sh          prepara en publicar/ todo lo que se sube
└── 27/                         edición 2026-27
    ├── index.html              portada de la edición
    ├── stpea-curso/            proyecto MyST: planificación y teoría
    └── ejemplos-myst/
        ├── index.html          índice de los ejemplos
        ├── uso-y-maquetacion/      proyecto MyST
        ├── recursos-multimedia/    proyecto MyST
        ├── reutilizar-y-enlazar/   proyecto MyST
        └── libros-ejecutables/     proyecto MyST con JupyterLite
```

Las páginas HTML sueltas se publican tal cual. Cada carpeta con `myst.yml` es un proyecto MyST independiente: se trabaja en él con `myst start` desde su carpeta y se construye por separado, con su propia ruta base.

## Publicar toda la asignatura

Requisitos: [Node.js](https://nodejs.org) 22 o superior, `npm install -g mystmd`, y para JupyterLite `pip install -r 27/ejemplos-myst/libros-ejecutables/requirements-lite.txt`.

1. Confirma los cambios en git (`git commit`): los zips de descarga de los ejemplos se hacen con `git archive` del último commit.
2. Construye el árbol, indicando la ruta que corresponde en el servidor a esta raíz:

   ```bash
   BASE_RAIZ=/ruta/de/la/asignatura ./construir-arbol.sh
   ```

3. Sube el contenido de `publicar/` a la carpeta de la asignatura, o empaquétalo:

   ```bash
   tar -czf stpea.tar.gz -C publicar .
   ```

`construir-arbol.sh` copia los ficheros sueltos que están en git y, en cada proyecto MyST, ejecuta `preparar-descarga.sh` (si existe) y `publicar.sh` (si existe; si no, `myst build --html`) con `BASE_URL=$BASE_RAIZ/<ruta del proyecto>`. De cada proyecto copia solo `_build/html`. La ruta del servidor solo aparece en el comando: no queda escrita en ningún fichero.

## Una edición nueva

Se copia `27/` como `28/` (o la que toque), se ajustan los textos y se añade la edición a `index.html`. La anterior sigue publicada tal como estaba.

## Licencia

José Luis Fernández Vindel. Contenido bajo licencia [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.es). Preparado con la ayuda de un asistente de inteligencia artificial (Claude, de Anthropic); el autor responde de su contenido.
