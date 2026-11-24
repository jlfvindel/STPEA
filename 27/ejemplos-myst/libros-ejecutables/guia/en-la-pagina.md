---
title: Celdas ejecutables en la propia página
short_title: Ejecutar en la página
label: en-la-pagina
---

Con la clave `jupyter` en la configuración, las celdas de código de un libro MyST se pueden ejecutar **en la misma página** donde se leen: el estudiante cambia un número, pulsa un botón y ve el nuevo resultado, sin abrir ningún otro programa. El código se ejecuta en un *núcleo* (*kernel*) de Python, y la clave `jupyter` dice dónde está ese núcleo.

## Cómo se ve

Con una configuración ejecutable, cada cuaderno muestra arriba un botón para **encender** el entorno de cálculo. Una vez conectado, aparecen botones para ejecutar todo el cuaderno, reiniciarlo o borrar las salidas, y cada celda tiene su propio botón de ejecutar. El código de las celdas se puede editar directamente en la página.

Los cambios no se guardan: al recargar la página, el cuaderno vuelve a su estado original. Es un espacio para experimentar, no para entregar trabajo.

## Tres sitios donde puede estar el núcleo

### En el navegador: `jupyter: lite`

```yaml
project:
  jupyter:
    lite: true
```

Es la configuración `myst-lite.yml`. Python se ejecuta dentro del navegador del estudiante, con Pyodide, igual que en JupyterLite. Para publicarlo basta un servidor web normal: no hay ningún servidor de cálculo.

Pruébalo:

```bash
myst --config myst-lite.yml start
```

Abre el [cuaderno de trayectorias](../cuadernos/trayectorias.ipynb), pulsa el botón de encendido y espera unos segundos: la primera vez se descarga Python en el navegador. Después, cambia `v0 = 20` por otro valor y pulsa *Run all cells* (ejecutar todo).

:::{warning} Necesita conexión a internet
El libro se sirve desde tu servidor, pero Python (Pyodide) y el núcleo se descargan, la primera vez, de servidores públicos de distribución de software (jsDelivr y unpkg). En un aula sin acceso a internet, el botón de encendido no llegará a conectar. Si eso es un problema, la alternativa es el JupyterLite completo con Pyodide alojado en el propio servidor, que se explica en [](#jupyterlite-institucional).
:::

### En el ordenador del estudiante: `jupyter: server`

```yaml
project:
  jupyter:
    server:
      url: http://localhost:8888/
      token: clase2026
```

Es la configuración `myst-local.yml`. El libro se conecta a un servidor Jupyter que corre en el propio ordenador, con su Python y todos sus paquetes. Es útil cuando los cuadernos necesitan paquetes que Pyodide no tiene, o mucha potencia de cálculo.

Hacen falta dos terminales. En la primera, dentro de la carpeta del proyecto, se arranca Jupyter:

```bash
jupyter server --IdentityProvider.token=clase2026 \
    --ServerApp.allow_origin=http://localhost:3000
```

`token` es la contraseña que el libro usa para conectarse, y tiene que coincidir con la de `myst-local.yml`. `allow_origin` autoriza a la página del libro (que se sirve en el puerto 3000) a usar este Jupyter. En la segunda terminal se arranca el libro:

```bash
myst --config myst-local.yml start
```

Con esta configuración aparece además, en cada cuaderno, un botón para abrirlo en JupyterLab.

### En Binder: `jupyter: binder`

```yaml
project:
  jupyter:
    binder:
      repo: USUARIO/REPOSITORIO
```

Si el proyecto está en un repositorio público de GitHub, el botón de encendido pide a mybinder.org un entorno con los paquetes de `requirements.txt` y conecta el libro a él. No hay configuración de ejemplo en este proyecto porque necesita un repositorio publicado. Las limitaciones son las de Binder: el primer arranque es lento y las sesiones se cierran tras unos minutos de inactividad ([](#opciones)).

## ¿Y los cuadernos de texto?

Todo lo anterior funciona igual con los cuadernos `.md`: abre [](#cuaderno-alcance) con `myst-lite.yml` y enciende el entorno. Así, un cuaderno de texto que se publica sin ejecutar (sin `--execute`) puede ejecutarse igualmente en el navegador del estudiante.

:::{tip} Para explorar más
- Contenido ejecutable en la guía de MyST: <https://mystmd.org/guide/integrating-jupyter>.
- Prueba a escribir en una celda una expresión con un error y ejecútala: el mensaje de error aparece como salida, como en Jupyter.
:::
