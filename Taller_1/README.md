# Taller de análisis de imágenes por software

## Propósito

Introducir el análisis de imágenes/video en el lenguaje de [Processing](https://processing.org/).

## Tareas

Implementar las siguientes operaciones de análisis para imágenes/video:

* Conversión a escala de grises: promedio _rgb_ y [luma](https://en.wikipedia.org/wiki/HSL_and_HSV#Disadvantages).
* Aplicación de algunas [máscaras de convolución](https://en.wikipedia.org/wiki/Kernel_(image_processing)).
* (solo para imágenes) Despliegue del histograma.
* (solo para imágenes) Segmentación de la imagen a partir del histograma.
* (solo para video) Medición de la [eficiencia computacional](https://processing.org/reference/frameRate.html) para las operaciones realizadas.

Emplear dos [canvas](https://processing.org/reference/PGraphics.html), uno para desplegar la imagen/video original y el otro para el resultado del análisis.

## Integrantes

|          Integrante         |  github nick  |
|-----------------------------|---------------|
|  Juan Sebastián Becerra   |   jsbecerrab    |
| Juan Sebastián Peña |   jspenaq     |


## Discusión

* Se crean varios canvas con PGraphics para mostrar los resultados del taller, estos canvas tienen el tamaño de la imagen original para facilitar la comparación.
* Para la conversion a escala de grises (tecla **g**) se implemento el promedio rgb y luma, con las teclas **a** y **l** se pueden ver los histogramas de cada método.
* Para las mascaras de convolucion (tecla **c**) se utilizan los kernel de edge detection, sharpen, y emboss.
* Para el video (tecla **v**) se muestra el framerate.
