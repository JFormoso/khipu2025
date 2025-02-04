library(tidyverse)
library(tidytext)
library(googlesheets4)
library(topicmodels)

df <- read_sheet("1mWUWcjc_kWH6KHWMkEjK6AHNpnJU-8cSivw27f4bdE0", sheet = "cohorte_todas")

df <- df |> 
  filter(autorizo_uso == "Sí", autorizo_publicacion == "Sí") 

lista_filtrado <- c("ninguna", "ninguno", "ninguna.", "ninguno.", "no lo se", "no lo sé", "no lo se.", "no lo sé.", "no se", "no sé", "no se.", "no sé.", "desconozco", "desconozco.")
lista_filtrado2 <- c(".", "A")

df <- df |> 
  mutate(barreras_ES = ifelse(str_to_lower(barreras_ES) %in% lista_filtrado, NA, barreras_ES))

df <- df |> 
  mutate(publico_general_ES = ifelse(str_to_lower(publico_general_ES) %in% lista_filtrado, NA, publico_general_ES))

df <- df |> 
  mutate(publico_general_ES = ifelse(publico_general_ES %in% lista_filtrado2, NA, publico_general_ES)) |> 
  mutate(barreras_ES = ifelse(barreras_ES %in% lista_filtrado2, NA, barreras_ES)) 

df <- df |>
  filter(!is.na(barreras_ES)|!is.na(publico_general_ES))
