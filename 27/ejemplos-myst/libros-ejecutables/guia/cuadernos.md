---
title: Cuadernos en un libro MyST
short_title: Cuadernos
label: cuadernos
---

Un cuaderno Jupyter mezcla texto, código y los resultados de ejecutarlo. MyST lo trata como una página más: se pone en el índice y aparece en el menú, con su texto, su código y sus salidas.

## Dos formatos de cuaderno

`.ipynb`, el cuaderno clásico
: Es el formato de Jupyter. Se edita con JupyterLab, VS Code o Colab, y **guarda las salidas** dentro del fichero. MyST las muestra tal cual, sin ejecutar nada. Es [el cuaderno de trayectorias](../cuadernos/trayectorias.ipynb).

`.md` con celdas de código
: Un fichero de texto MyST con bloques `code-cell`. No guarda salidas: hay que ejecutarlo al construir el libro. Se edita con cualquier editor, y las diferencias entre versiones se leen bien. Es [](#cuaderno-alcance).

En un `.md`, el título y las demás opciones de la página van en el frontmatter, como en cualquier página. Además, debe indicar con qué núcleo (*kernel*) se ejecuta:

```yaml
---
title: 'Cuaderno de texto: el alcance según el ángulo'
kernelspec:
  name: python3
  display_name: Python 3
---
```

Cada celda de código se escribe así:

````markdown
```{code-cell} python
import numpy as np
print(np.sqrt(2))
```
````

En un `.ipynb` también se puede poner un frontmatter, en la primera celda de texto. Pero los estudiantes que abran el cuaderno en Jupyter lo verán como texto extraño al principio. Por eso, el cuaderno de trayectorias empieza simplemente con un título (`# Cuaderno: trayectorias de un proyectil`), que MyST toma como título de la página, y el índice le pone un título más corto para el menú:

```yaml
- file: cuadernos/trayectorias.ipynb
  title: Trayectorias
```

## Cuándo se ejecuta el código

Por defecto, MyST **no ejecuta** nada: muestra las salidas que ya tienen los `.ipynb`, y los `.md` aparecen sin salidas. Para que ejecute los cuadernos al construir:

```bash
myst start --execute
myst build --html --execute
```

MyST arranca entonces un servidor Jupyter en el ordenador, ejecuta cada cuaderno de principio a fin y guarda los resultados en una caché (`_build/execute`). La siguiente vez solo vuelve a ejecutar los cuadernos que hayan cambiado. Para forzar que se ejecute todo de nuevo, se borra esa caché con `myst clean --execute`.

:::{warning} Ejecutar al construir exige el entorno completo
Para usar `--execute`, el ordenador que construye el libro necesita Python, `jupyter-server` y todos los paquetes que importan los cuadernos (`requirements.txt`). Si falta alguno, la construcción avisa del error y la celda queda sin salida, o con el error como salida.
:::

Prueba a arrancar este proyecto sin `--execute` y abre [](#cuaderno-alcance): verás el código sin resultados. Con `--execute`, aparecen.

## Opciones de las celdas

Las celdas admiten opciones. En un `.ipynb` se escriben como comentarios especiales al principio de la celda (`#| opción: valor`); en un `.md`, como opciones de la directiva:

| Opción | Efecto |
|---|---|
| `label` | Etiqueta la salida para citarla o incrustarla |
| `caption` | Pone un pie a la salida, que se convierte en figura numerada |
| `tags: [remove-input]` | Muestra la salida, pero no el código |
| `tags: [remove-output]` | Muestra el código, pero no la salida |
| `tags: [remove-cell]` | Ejecuta la celda sin mostrar nada (útil para preparar datos) |

Por ejemplo, la celda de la gráfica del [cuaderno de trayectorias](../cuadernos/trayectorias.ipynb) empieza así:

```python
#| label: fig-nb-trayectorias
#| caption: Trayectorias calculadas en el cuaderno.
import matplotlib.pyplot as plt
```

## Reutilizar los resultados

Una salida con etiqueta se puede citar e incrustar en cualquier página, como en el proyecto 3. Así se presenta en la explicación un resultado calculado en el cuaderno:

```markdown
:::{embed} #fig-nb-trayectorias
:::
```

Resultado:

:::{embed} #fig-nb-trayectorias
:::

La [](#fig-nb-trayectorias) se ha calculado en el cuaderno, y aquí solo se muestra. Si se cambia el cuaderno y se vuelve a ejecutar, la figura de esta página cambia también.

:::{note} La incrustación trae también el código
Con MyST 1.13, incrustar la salida de una celda trae la celda entera, con su código. La guía de MyST documenta la opción `:remove-input:` de `embed` para quitarlo, pero en las pruebas de este proyecto no tuvo efecto. Si solo se quiere la imagen, una alternativa es que el cuaderno la guarde como fichero (`plt.savefig(...)`) y usarla como una figura normal.
:::

:::{tip} Para explorar más
- Cuadernos y ejecución en la guía de MyST: <https://mystmd.org/guide/execute-notebooks>.
- Abre `cuadernos/trayectorias.ipynb` con JupyterLab, cambia la velocidad inicial, ejecuta todo y guarda. Vuelve al libro: la gráfica ha cambiado sin construir nada más.
:::
