---
title: 'Proyecto 4: libros ejecutables'
short_title: Inicio
label: inicio
---

Un **libro ejecutable** es un material en el que el código no es solo texto: el estudiante puede ejecutarlo, cambiar los datos y ver cómo cambia el resultado. Este proyecto muestra cómo incluir cuadernos Jupyter en un libro MyST y qué opciones tiene el autor para que los estudiantes los ejecuten, con atención especial a la que solo necesita un servidor web de la institución: **JupyterLite**.

Los cuadernos siguen con el tiro parabólico de los proyectos anteriores, ahora calculado en Python.

:::{note} Sobre la elaboración de este material
:class: dropdown
Este proyecto lo ha preparado José Luis Fernández Vindel en colaboración con un asistente de inteligencia artificial (Claude, de Anthropic). La estructura, los textos, los cuadernos y los guiones se han elaborado en diálogo con el asistente; el autor ha decidido el enfoque, ha revisado el resultado y responde de su contenido. Los ejemplos se han comprobado con MyST 1.13.0, JupyterLite 0.8.7 y Python 3.13.
:::

Puedes {download}`descargar la fuente completa del proyecto <descargas/libros-ejecutables.zip>` para ejecutarlo y modificarlo en tu ordenador. También está en el botón de descarga, arriba a la derecha de cada página.

## Cómo está organizado

Guía
: [Cuadernos en un libro MyST](#cuadernos): cómo se incluyen, cuándo se ejecutan y cómo se reutilizan sus resultados. [Opciones de ejecución](#opciones) para los estudiantes, comparadas. [Celdas ejecutables en la propia página](#en-la-pagina). [JupyterLite en el servidor de la institución](#jupyterlite-institucional).

Cuadernos
: Un cuaderno Jupyter clásico (`.ipynb`) y un cuaderno escrito como texto (`.md`).

## Tres configuraciones

| Fichero | Se usa con | Qué produce |
|---|---|---|
| `myst.yml` | `myst start` | El libro con los resultados ya calculados; en la página no se ejecuta nada |
| `myst-lite.yml` | `myst --config myst-lite.yml start` | El mismo libro, con un botón que activa Python **en el navegador** del estudiante |
| `myst-local.yml` | `myst --config myst-local.yml start` | El mismo libro, conectado a un Jupyter que corre en el ordenador |

Las dos últimas heredan todo de la primera (`extends: myst.yml`) y solo añaden la clave `jupyter`.

## Lo que hace falta instalar

Para construir el libro basta MyST, como en los proyectos anteriores. Para ejecutar los cuadernos en el ordenador, o para usar `myst-local.yml`, hace falta además Python con los paquetes de `requirements.txt`:

```bash
pip install -r requirements.txt jupyter-server
```

Para publicar con JupyterLite, quien publica necesita también los de `requirements-lite.txt`. Los estudiantes no necesitan instalar nada.

:::{note} Los cuatro proyectos
1. Usar MyST y maquetar.
2. Recursos multimedia.
3. Reutilizar y enlazar.
4. **Libros ejecutables** (este).
:::
