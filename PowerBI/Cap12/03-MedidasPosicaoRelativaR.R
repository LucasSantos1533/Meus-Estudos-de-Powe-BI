#Estatística Básica

#Parte 3 - Medidas de Posição Relativa

#Cuidado: a linguagem R é case sensitive!

#definindo a pasta de trabalho

setwd("C:\PowerBI\Cap12")
getwd()

#Carregando o dataset
vendas <- read.csv("vendas.csv", fileEncoding = "windows-1252")

#Resumo dos dados
head(vendas)  #cabecalho da tabela de vendas
tail(vendas) # ultimas linhas da tabela de vendas
View(vendas) #mostra tabela completa de vendas
View(vendas)
View(vendas)

#Medidas de Tendência Central
summary(vendas$valor)
summary(vendas[c('valor','custo')])  #filtra somente as duas colunas " valor" e "custo"

#explorando variaveis numéricas
mean(vendas$valor)
median(vendas$valor)
quantile(vendas$Valor)   #essa função calcula os quartis
range(vendas$Valor)   #Essa função da o intervalo do valor minimo, ao valor máximo
diff(range(vendas$Valor))  #calcula a diferença