# Taller de shaders

## Propósito

Estudiar los [patrones de diseño de shaders](http://visualcomputing.github.io/Shaders/#/4).

## Tarea

1. Hacer un _benchmark_ entre la implementación por software y la de shaders de varias máscaras de convolución aplicadas a imágenes y video.
2. Implementar un modelo de iluminación que combine luz ambiental con varias fuentes puntuales de luz especular y difusa. Tener presente _factores de atenuación_ para las fuentes de iluminación puntuales.
3. (grupos de dos o más) Implementar el [bump mapping](https://en.wikipedia.org/wiki/Bump_mapping).

## Integrantes

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
|Stefania Arguelles | sarguellesr|
|Johan Nicolas Torres Mendoza |nicolasto2094|

## Informe

### 1. Máscaras de convolución

Las mascaras usadas fueron: 

- Repujado
- 3 Tipos de detección de bordes
- Nitidez
- Realzado 

Interacciones
- **Teclas del 0-5:** Varia el tipo de matriz de  convolución que se está usando. 
- **Cualquier otra tecla:** Usa la matriz identidad para no afectar a la imagen original.  

Resultados: 

Después de comparar las imágenes obtenidas usando shaders para el cálculo de la convolución con las imagenés calculadas sin usar shaders (usando solo processing), pudimos notar que en la mayoría de los casos no se puede señalar una gran diferencia, excepto en el segundo tipo de detección de bordes, donde la imagen procesada por el shader muestra un resultado más fuerte, en donde ya la imagen no se puede distinguir. 

En cuanto al tiempo de ejecución también se obtuvieron resultados similares, sin embargo en el grado de dificultad, nos llevó más tiempo implementar los shaders para este procesamiento de imágenes que hacerlo directamente desde Processing.

### 2. Modelo de iluminación



## Entrega

Fecha límite ~~Lunes 1/7/19~~ Domingo 7/7/19 a las 24h. Sustentaciones: 10/7/19 y 11/7/19.
