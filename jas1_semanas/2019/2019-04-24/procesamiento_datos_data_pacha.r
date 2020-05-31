if (!require("pacman")) install.packages("pacman")
library(dplyr)
pacman::p_load(tradestatistics)

paises <- c("arg", "bol", "chl", "col", "cri", "cub", "dom", "ecu", "slv", "gtm", "hnd", "mex", "nic", "pan", "pry", "per", "ury", "ven")

hispanoamerica <- ots_create_tidy_data(years = 2010:2017, reporters = paises, partners = "all", include_shortnames = TRUE, include_communities = TRUE)

glimpse(hispanoamerica)

skimr::skim(hispanoamerica)

