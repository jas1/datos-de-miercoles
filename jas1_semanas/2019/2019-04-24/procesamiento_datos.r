# procesando datos incaa
library(pdftools)
library(here)
library(dplyr)
pdf_path <- here::here("jas1_semanas","2019","2019-04-24","20190424_Ranking_Peliculas.pdf")
texto_extraido <- pdftools::pdf_text(pdf = pdf_path)

txt_path <- here::here("jas1_semanas","2019","2019-04-24","20190424_Ranking_Peliculas.txt")
conexion_archivo <- file(txt_path,encoding = "UTF-8")
writeLines(text = texto_extraido,con = conexion_archivo)
close(conexion_archivo)

head(texto_extraido)
# ?stdout
# stdout()
conexion_archivo_read <- file(txt_path,encoding = "UTF-8")
texto_extraido_read_lines <- readLines(con = conexion_archivo_read,encoding = "UTF-8")
head(texto_extraido_read_lines)
# Pelicula  Entradas Total       Precio Venta Total
# Fecha Estreno
# Ranking de Peliculas
# Datos actualizados al:23/4/2019 17<U+E353>37<U+E353>33" 

datos_quitar <- "                                                                                   Datos actualizados al:23/4/2019 17<U+E353>37<U+E353>33"
texto_extraido_read_lines %>% stringr::str_replace(datos_quitar,"")