# Utilidades Publicación

En esta sección iremos cargando recomendaciones sobre cómo publicar si te toca participar como adminsitrador o queres proponer pull requests para nuevos datos


## como armar el diccionario de datos ?

1. tener el dataset ya armado

2. ejecutar el codigo siguiente, reemplazando la variable  `tus_datos_procesados` por como se llame tu variable de datos.

```
library(tidyverse)
library(knitr)

# la variable: tus_datos_procesados, es el dataset que armaste para el desafio

df <- tus_datos_procesados 
data_frame(Variable = names(df)) %>% 
    mutate(class = map(df, typeof)) %>% 
    mutate(Clase = case_when(class=="double"~"decimal",
                                class=="character"~"caracter",
                                class=="logical"~"lógico",
                                class=="integer"~"entero")) %>% 
    mutate(Descripcion=Variable) %>% 
    kable()
```

3. del texto generado agregar la descripción de las variables

## como hacer un pull request:

si ya tenes github del proyecto, es probable que ya tengas tu repositorio.
y que guardes tus datos en alguna carpeta, o te guardes tus utilidades, que hacen que difiera del repositorio original.

por lo tanto tenes que caer en "seleccionar los commits" que queres enviar al PR

esto signifca que tenes que ordenar tu codigo de una forma en particular en la cual elegirias que queres subir. la [fuente original](https://stackoverflow.com/questions/5256021/send-a-pull-request-on-github-for-only-latest-commit/)

pasos: 

- armar el commit donde se van a subir las cosas
- hacer commit a tu reposotorio local
- hacer push a tu repositorio de github

- agregar un remote de donde vas a sacar las cosas

```
git remote add upstream https://github.com/cienciadedatos/datos-de-miercoles.git
```
- traerte el estado actual del repo original a tu pc:

```
git remote update
```

- Crear una nueva branch ( rama ) con los datos del repo recien bajado reemplazar `nombre_rama_commitear` por un nombre de rama que sea significativo.

```
git checkout -b nombre_rama_commitear upstream/master
```


- en la rama nueva, seleccionar los commits de la otra rama segun codigo sha. ( esto lo podes ver en github cual es el codigo del commit subido. son numeros y letras gralmente) reemplazar el codigo `1234abc` por el codigo de tu rama

```
git cherry-pick 1234abc
```

repetir este paso con todos los commits que se desean. sin embargo se recomienda hacer de a 1 para reducir potenciales errores. 

- enviar la nueva rama a tu repo original de git asi queda disponible para hacer Pull Request ( PR )
recordar que `nombre_rama_commitear` tiene que decir el nombre que vos le pusiste.

```
git push origin nombre_rama_commitear
```
- ir a la pagina de github del proyecto en TU repositorio en el navegador a la seccion de pull requests en mi caso es: ( donde jas1 es el nombre de usuario)

```
https://github.com/jas1/datos-de-miercoles/pulls 
```

- apretar el boton verde que dice "New pull request"

- apareceran varias opciones, lo unico que hay que cambiar es que compare contra la rama (branch) nueva  que creamos ( esto aparece justo arriba del boton verde de la pantalla que aparecio , dice: `compare: master` )
hay que cambiarlo por `compare: nombre_rama_commitear`  siendo `nombre_rama_commitear` el nombre que le psuiste a la rama (branch)


- luego queda esperar. si aceptan tu PR , te va a llegar un mail con la cuenta que te registraste.





