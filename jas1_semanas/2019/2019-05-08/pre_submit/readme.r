# probando

# install.packages("gutenbergr")
library(gutenbergr)
library(dplyr)
library(stringi)
library(purrr)
library(tidyr)

# luego de algunas vueltas pude leer el encoding de don quijote. probe coN: 

# stringi::stri_enc_detect(quijote$text[6])
# stringi::stri_conv(str = quijote$text[6], from = "ISO-8859-1", to = "UTF-8")

# el readr::guess_encoding , me fiej como estaba implmententado y de aahi saque el: stri_enc_detect
# leugo con stri_conv hice que me lo convirtiera a UTF8

# aca la metadata de los trabajos en español
gt_es_metadata <- gutenbergr::gutenberg_works(languages = "es")
glimpse(gt_es_metadata)
gt_es_metadata %>% 
    count(author,sort = TRUE) %>% 
    count(n,sort = TRUE) %>% 
    mutate(totales = n * nn) %>% 
    arrange(desc(n)) %>% 
    mutate(sum_acum =cumsum(totales)) %>% 
    rename(cantidad_textos=n,
           frecuencia_cantidad_textos = nn, 
           total_cantidad_por_frecuencia=totales,
           acumulado_total=sum_acum)
    

# 
# # aca la obtencion de uno en particular para probar como vienen
# quijote <- gutenbergr::gutenberg_download(gutenberg_id = 2000) %>%
#     mutate(texto=stringi::stri_conv(str = text, from = "ISO-8859-1", to = "UTF-8"))


# tratando de generalizar # GUARDA BAJA TODO !
# metadata_con_texto <- gt_es_metadata %>%
#     mutate(textos = purrr::map(.x=gutenberg_id,.f=function(g_id){
#         texto_actual <- gutenbergr::gutenberg_download(gutenberg_id = g_id) %>%
#             mutate(texto=stringi::stri_conv(str = text, from = "ISO-8859-1", to = "UTF-8"))
#         texto_actual
#     }))

# GUARDA guarda lo que quedo en el escritorio par ano bajar todo devuelta, acomodar el path.
# path_rds <- here::here("jas1_semanas","2019","2019-05-08","pre_submit","metadatos_con_textos.rds")
# saveRDS(metadata_con_texto,file = path_rds,ascii = FALSE)
# read_metadata_texto <- readRDS(path_rds) # 140 MB ~
# ver cuanta tienen de largo en lineas los textos
# read_metadata_texto %>% 
#     mutate(largo_textos=purrr::map(textos,nrow)) %>% 
#     unnest(largo_textos)
# 

# expandir el datset a los textos.
# unnested_textos <- read_metadata_texto %>% unnest(textos)
# unnested_textos_2 <- unnested_textos %>% select(gutenberg_id,title,gutenberg_author_id,language,texto)
# unnested_textos_2

# guardar / leer los textos expandidos.
path_txt <- here::here("jas1_semanas","2019","2019-05-08","pre_submit","metadatos_con_textos.txt")
# readr::write_delim(unnested_textos_2,delim = "\t",path = path_txt)
cargar_textos <- readr::read_delim(path_txt,delim = "\t")

# algun filtro ?
cargar_textos %>% 
    count(title) %>% 
    filter(n > 10000) %>% 
    View()



# Otras cosas que probe

# View(quijote)
# as.character(quijote$text[6])
# cat(quijote)
# stringi::stri_enc_isutf8(quijote$text[6])
# stringi::stri_enc_mark(quijote$text[6])
# stringi::stri_encode(quijote$text[6], "", "UTF-8") 
# stringi::stri_encode(quijote$text[6], "", "ASCII") 
# stringi::stri_encode(quijote$text[6], "", "") 
# stringi::stri_conv(str = quijote$text[6], from = "ISO-8859-1", to = "UTF-8")
# readr::guess_encoding(quijote$text[6])

# esto funciono
# stringi::stri_enc_detect(quijote$text[6])
# stringi::stri_conv(str = quijote$text[6], from = "ISO-8859-1", to = "UTF-8")

# esto funciono
# stringi::stri_enc_detect(quijote$text[6])
# stringi::stri_conv(str = quijote$text[6], from = "ISO-8859-1", to = "UTF-8")