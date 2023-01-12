#Exercicio

#Cuidado: A Linguagem R é case sensitive!

#Definindo a pasta de trabalho

setwd("C:/PowerBI/Cap12")
getwd()

#Carregando o dataset
notas <- read.csv("Notas.csv", fileEncoding = "windows-1252")

#Exercício 1: Apresente um resumo de tipos de dados e estatísticas do dataset.
View(notas) #mostra resumo da tabela notas inteira
str(notas) #resumo dos tipos de dados
summary(notas$)