---
title: Cómo pueden ejecutar los estudiantes los cuadernos
short_title: Opciones de ejecución
label: opciones
---

Publicar un cuaderno es fácil; lo difícil es que cada estudiante tenga dónde ejecutarlo. Hay cinco caminos habituales. Se diferencian en **dónde corre Python**, en qué tiene que hacer el estudiante y en qué tiene que mantener la institución.

## Comparación

| | Local | Binder | Colab | JupyterHub institucional | JupyterLite |
|---|---|---|---|---|---|
| Dónde corre Python | Ordenador del estudiante | Servidor público temporal | Servidores de Google | Servidor de la institución | **Navegador del estudiante** |
| El estudiante instala… | Python y Jupyter | Nada | Nada | Nada | Nada |
| Cuenta necesaria | No | No | De Google | Institucional | No |
| Paquetes disponibles | Todos | Los del repositorio | Muchos, preinstalados | Los que instale la institución | Los adaptados a Pyodide |
| ¿Se conserva el trabajo? | Sí, en su disco | No: la sesión se borra | Sí, en su Drive | Sí, en el servidor | En el navegador (conviene descargarlo) |
| Lo que publica el autor | Los ficheros | Un repositorio público | Un repositorio o un Drive | Los ficheros en el servidor | **Ficheros en un servidor web** |
| Mantenimiento institucional | Ninguno | Ninguno | Ninguno | Alto | Muy bajo |

## Local

El estudiante instala Python y Jupyter (o una distribución como Anaconda), descarga los cuadernos y los abre en JupyterLab o en VS Code. Tiene toda la potencia de su ordenador y todos los paquetes, y su trabajo se queda en su disco.

El precio es la instalación: con un grupo numeroso, siempre hay equipos donde algo falla, y la primera sesión se va en resolverlo. Este proyecto ofrece además una forma de conectar el propio libro a ese Jupyter local: la configuración `myst-local.yml`, que se explica en [](#en-la-pagina).

## Binder

[mybinder.org](https://mybinder.org) es un servicio gratuito que, a partir de un repositorio público (por ejemplo, en GitHub), construye un entorno con los paquetes de su `requirements.txt` y abre JupyterLab en el navegador. El enlace tiene esta forma:

```text
https://mybinder.org/v2/gh/USUARIO/REPOSITORIO/main?urlpath=lab/tree/cuadernos/trayectorias.ipynb
```

No pide cuenta ni instalación, pero las sesiones son temporales. Según sus normas de uso, Binder cierra las sesiones que llevan más de 10 minutos inactivas, y no garantiza más de seis horas por sesión. Al cerrarse, el trabajo se pierde si no se ha descargado. La primera vez que se abre un repositorio, construir el entorno puede tardar varios minutos.

## Google Colab

[Colab](https://colab.research.google.com) abre un cuaderno publicado en GitHub (o guardado en Google Drive) y lo ejecuta en servidores de Google. El enlace tiene esta forma:

```text
https://colab.research.google.com/github/USUARIO/REPOSITORIO/blob/main/cuadernos/trayectorias.ipynb
```

Es cómodo y potente, pero exige que cada estudiante tenga una cuenta de Google, y su trabajo y sus datos quedan en servicios de una empresa externa. En un contexto educativo, eso puede chocar con la política de protección de datos de la institución.

## JupyterHub institucional

Algunas instituciones mantienen su propio servidor JupyterHub: cada estudiante entra con su cuenta institucional y tiene su espacio de trabajo permanente. Es la solución más completa, pero también la más cara: hay que mantener servidores con capacidad de cálculo para todos los usuarios a la vez.

## JupyterLite

JupyterLite es Jupyter **sin servidor de cálculo**. Python está compilado para ejecutarse dentro del navegador (con Pyodide), así que el servidor solo entrega ficheros, como cualquier página web, y el cálculo lo hace el ordenador del estudiante.

Para una institución, es la opción con mejor equilibrio:

- No hay que instalar nada, ni el estudiante ni el servidor: basta el servidor web donde ya se publica el libro.
- No hace falta cuenta, y el código de los estudiantes no sale de su ordenador.
- Aguanta cualquier número de estudiantes, porque cada uno calcula en su equipo.

Tiene también limitaciones:

- Solo están los paquetes adaptados a Pyodide. Entre ellos están los habituales en docencia, como NumPy, pandas, Matplotlib o SciPy, pero no todos.
- La primera carga descarga Python en el navegador (varias decenas de megas) y tarda unos segundos.
- Lo que el estudiante guarda se queda en el almacenamiento de su navegador: si borra los datos de navegación, lo pierde. Conviene que descargue su trabajo.
- Los cálculos pesados van más lentos que en un Python nativo.

Hay dos formas de usarlo, y este proyecto prepara las dos:

- **Dentro del propio libro:** las celdas se ejecutan en la misma página que el estudiante lee. Es la configuración `myst-lite.yml`, explicada en [](#en-la-pagina).
- **Como JupyterLab completo:** junto al libro se publica una copia de JupyterLab que funciona en el navegador, con los cuadernos ya cargados. Se explica en [](#jupyterlite-institucional).

:::{tip} Para explorar más
- JupyterLite: <https://jupyterlite.readthedocs.io>. Su página principal tiene una demostración que se abre en el navegador.
- La lista de paquetes que incluye Pyodide: <https://pyodide.org/en/stable/usage/packages-in-pyodide.html>.
:::
