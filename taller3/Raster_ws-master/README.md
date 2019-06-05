# Taller raster

## Propósito

Comprender algunos aspectos fundamentales del paradigma de rasterización.

## Tareas

Emplee coordenadas baricéntricas para:

1. Rasterizar un triángulo.
2. Sombrear su superficie a partir de los colores de sus vértices.
3. (opcional para grupos menores de dos) Implementar un [algoritmo de anti-aliasing](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation) para sus aristas.

Referencias:

* [The barycentric conspiracy](https://fgiesen.wordpress.com/2013/02/06/the-barycentric-conspirac/)
* [Rasterization stage](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage)

Implemente la función ```triangleRaster()``` del sketch adjunto para tal efecto, requiere la librería [nub](https://github.com/nakednous/nub/releases).

## Integrantes

Complete la tabla:

| Integrante 		      | github nick |
|-----------------------------|-------------|
|Johan Nicolás Torres Mendoza |nicolasto2094|
|Stefania Arguelles Reyes     |sarguellesr  |

## Discusión

Describa los resultados obtenidos. En el caso de anti-aliasing describir las técnicas exploradas, citando las referencias.
La rasterización es el proceso por el cual una imagen descrita en un formato gráfico vectorial se convierte en un conjunto de píxeles, se evidencia el suavisado que se genera al realizar raster, la calidad en la representación de una figura, en este caso del triángulo, la verdad es que en la distancia del observador y la cantidad de píxeles usados.

* El antialiasing es un conjunto de técnicas utilizadas para mejorar la calidad final de la imagen, por la facilidad nos valimos del algoritmo FXAA, FXAA es el acrónimo de Fast Approximate Anti-Aliasing,y es una técnica cuyo objetivo es mejorar la calidad, sin perder velocidad.
## Entrega

* Plazo: 2/6/19 a las 24h.
