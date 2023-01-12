#Estatistica Básica

#parte1 - Medidas de Dispersão

#Definindo a pasta de trabalho
setwd("C:\PowerBI\Cap12")
getwd()

#carregando o dataset
vendas <- read.csv("Vendas.csv", fileEncoding = "windows-1252")

#resumo do dataset
view(vendas)                  #visualizar contêudo do arquivo
str(vendas)                 # resumo sobre as variaveis, e os tipos de dados
summary(vendas$Valor)       #Resumo Estatistico, resumo das principais estatisticas básicas

#variância
var(vendas$Valor)

#Desvio Padrão
sd(vendas$Valor)