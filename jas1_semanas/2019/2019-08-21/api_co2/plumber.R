library(plumber) # install.packages(plumber)
library(tidyverse) # install.packages(tidyverse)

# leer ?png
# leer ?ggsave
# otros:
# codigo plumber: https://github.com/rstudio/plumber/blob/master/R/images.R
# docu plumber: https://www.rplumber.io/docs/rendering-and-output.html#response-object
# uno de stack overflow: https://stackoverflow.com/questions/50033857/serve-arbitrary-image-files-through-plumber

#* Plotear directo
#* @png (width = 10 , height = 7,units="in" , res=300)
#* @get /plot
function(){
    co2_ingreso <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-08-21/co2_ingreso.csv")

    line_plot_emisiones <- co2_ingreso %>% 
        ggplot(aes(x=anio,y=emision_co2,color=grupo))+
        # geom_point()+
        geom_line()+
        scale_x_continuous(breaks = seq(from=1955,to=2015,by=5))+
        facet_grid(grupo~.,scales = "free_y")+
        theme_light()+
        theme(legend.position = "none",
              axis.text.x = element_text(angle=90),
              strip.text.y = element_text(angle = 360))+
        labs(x="",y="",caption="#DatosdeMieRcoles",
             title="Emisión de CO2 por grupos de ingreso\nexpresado en toneladas métricas per cápita",
             subtitle = "desde 1960 hasta 2014")
    print(line_plot_emisiones)
}

#* Plotear con imagen intermedia; OJO GENERA ARCHIVO INTERMEDIO!
#* @serializer contentType list(type='image/png')
#* @get /plot_file
function(){
    co2_ingreso <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-08-21/co2_ingreso.csv")
    
    line_plot_emisiones <- co2_ingreso %>% 
        ggplot(aes(x=anio,y=emision_co2,color=grupo))+
        # geom_point()+
        geom_line()+
        scale_x_continuous(breaks = seq(from=1955,to=2015,by=5))+
        facet_grid(grupo~.,scales = "free_y")+
        theme_light()+
        theme(legend.position = "none",
              axis.text.x = element_text(angle=90),
              strip.text.y = element_text(angle = 360))+
        labs(x="",y="",caption="#DatosdeMieRcoles",
             title="Emisión de CO2 por grupos de ingreso\nexpresado en toneladas métricas per cápita",
             subtitle = "desde 1960 hasta 2014")
    
    salida_file <- 'tmp/salida.png' # OJO GENERA ARCHIVO INTERMEDIO!
    ggsave(salida_file,line_plot_emisiones,width = 10,height = 7)
    readBin(salida_file,'raw',n = file.info(salida_file)$size)
}
