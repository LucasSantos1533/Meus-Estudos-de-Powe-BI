# Estatística Básica

# parte 1 - Medidas de Posição

# Definindo a pasta de trabalho
#Substitua o caminho abaixo pela pasta no seu computador

setwd("C:/PowerBI/Cap12")
getwd("")

 # Carregando o dataset
vendas <- read.csv("Vendas.csv" , fileEncoding = "windows-1252")

#Resumo do dataset
view(vendas)
str(vendas)
summary(vendas$Valor)
summary(vendas$Custo)

# Calculando a média com a função Mean
?mean
mean(vendas$Valor)
mean(vendas$Custo)
# Aqui calculamos a média  das colunas "Valor" e "Custo" da tabela vendas

#Iremos mostrar exemplo de como calcular a mediana

median(vendas$Valor)
median(vendas$Custo)

#vamos calcular o valor de Moda
#criaremos uma função

moda <- function(v) {
   valor_unico <- unique(v) 
   valor_unico[which.max(tabulate(match(v, valor_unico)))]
}

#obtendo a Moda
#Chamando a função
resultado <- moda(vendas$Valor)
print(resultado)

#Instalando o ggplot2
 install.packages("ggplot2")
  library(ggplot2)  
 #Aqui nós estamos fazendo o carregamento na 
 
 #cria o gráfico
 ggplot(vendas) + 
   stat_summary(aes(x = Estado,
                    y = Valor),
                fun = mean,
                geom = "bar",
                fill = "lightgreen",
                col = "grey50") +
   labs(title = " Média de valor por Estado")