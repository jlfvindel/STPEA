---
title: 'Cuaderno de texto: el alcance según el ángulo'
short_title: Alcance
label: cuaderno-alcance
kernelspec:
  name: python3
  display_name: Python 3
---

Este cuaderno no es un `.ipynb`, sino un fichero `.md` con **celdas de código**. MyST lo trata como un cuaderno: lo ejecuta al construir el sitio si se le pide con `--execute`, y muestra las salidas debajo de cada celda. Al ser texto, se edita con cualquier editor y se lleva bien con el control de versiones.

## El alcance para todos los ángulos

```{code-cell} python
import numpy as np

v0, g = 20, 9.81
angulos = np.arange(0, 91, 1)
alcance = v0**2 * np.sin(np.radians(2 * angulos)) / g

print(f"Alcance máximo: {alcance.max():.1f} m, con {angulos[alcance.argmax()]}°")
```

```{code-cell} python
:label: fig-nb-alcance
:caption: El alcance en función del ángulo de lanzamiento, para 20 m/s.

import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(7, 3.2))
ax.plot(angulos, alcance, linewidth=2)
ax.axvline(45, linestyle="--", color="gray")
ax.set_xlabel("ángulo (grados)")
ax.set_ylabel("alcance (m)")
ax.spines[["top", "right"]].set_visible(False)
plt.show()
```

La curva es simétrica respecto de 45°: dos ángulos que suman 90° llegan al mismo punto.

## Celdas que no muestran su código

Con la etiqueta `remove-input`, la celda se ejecuta pero solo se ve su resultado. Es útil cuando el código no es lo que se quiere enseñar:

```{code-cell} python
:tags: [remove-input]

for a in (15, 30, 45, 60, 75):
    r = v0**2 * np.sin(np.radians(2 * a)) / g
    print(f"{a:>2}°: {r:5.1f} m")
```
