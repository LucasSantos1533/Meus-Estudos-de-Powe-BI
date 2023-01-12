#**********************************************
#   Microsoft Power BI para Data Science, versão 2.0                      
#
#         Data Science Academy
#         
#               Mini-Projeto 3
#
#Prevendo a Inadimplência de clientes com Machine Learning e Power BI
#
#**********************************************

#Definindo a pasta de trabalho
setwd("C:/PowerBI/Cap15")
getwd()

#Definição do Problema
#Leio o manual em pdf no capitulo 15 do curso como a definição do problema

#Instalando os pacotes para o projeto
#Obs: Os pacotes precisam ser instalados apenas uma vez
install.packages("Amelia")  
install.packages("caret")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("reshape")
install.packages("randomForest")
install.packages("e1071")

#Resumo sobre cada pacote
# Amelia -> Pacote feito para tratar valores ausentes.
#Caret -> É um dos pacotes mais famosos da linguagem R, 
#    ele permite construir modelos de Machine Learning é também pré processar os dados.
#ggplot2 -> Pacote para construção de gráficos.
#dplyr -> É um pacote para tratar dados, manipular dados.
#reshape - > É um pacote para mudar o formato dos dados.
#RandomForest & e1071 -> São pacotes feitos para trabalhar com Machine Learning

#Carregando os pacotes
library(Amelia)
library(ggplot2)
library(caret)
library(reshape)
library(randomForest)
library(dplyr)
library(e1071)

#Carregando o dataset

#Fonte: https://archive.ics.uci.edu/ml/datasets/default+of+credit+card+clients
dados_clientes <-read.csv("dados/dataset.csv")

#visualizando os dados e sua estrutura
View(dados_clientes)
str(dados_clientes)
summary(dados_clientes)

################## Análise Exploratória, Limpeza e Transformação###############

#Removendo a primeira coluna ID
dados_clientes$ID <-NULL
dim(dados_clientes)  
View(dados_clientes)

#Para remover a coluna Id pegamos o dataset, minha coluna id e atribuo um valor nulo


#Renomeando a coluna classe
colnames(dados_clientes)
colnames(dados_clientes)[24] <- "inadiplente"
colnames(dados_clientes)
View(dados_clientes)

#Verificando valores ausentes e removendo do dataset
sapply(dados_clientes,function(x) sum(is.na(x)))
?missmap
missmap(dados_clientes, main = "Valores Missing observados")
dados_clientes <- na.omit(dados_clientes)

#Convertendo os atriubtos genero, escolaridade, estado civil e idade
#para fatores (categorias)

#renomeando colunas categóricas
colnames(dados_clientes)
colnames(dados_clientes)[2] <-"Genero"
colnames(dados_clientes)[3] <-"Escolaridade"
colnames(dados_clientes)[4] <-"Estado_Civil"
colnames(dados_clientes)[5] <-"Idade"
colnames(dados_clientes)

#Aqui renomeamos os nomes das colunas



#Genero
View(dados_clientes$Genero)
str(dados_clientes$Genero)
summary(dados_clientes$Genero)
?cut
dados_clientes$Genero <- cut(dados_clientes$Genero,
                             c(0,1,2),
                             labels = c("Masculino",
                                        "Feminino"))

View(dados_clientes$Genero)
str(dados_clientes$Genero)
summary(dados_clientes$Genero)

#Escolaridade
str(dados_clientes$Escolaridade)
summary(dados_clientes$Escolaridade)
dados_clientes$Escolaridade <-cut(dados_clientes$Escolaridade,
                                  c(0,1,2,3,4),
                                  labels = c("Pós graduado",
                                             "|Graaduado",
                                             "Ensino Medio",
                                             "OUtros"))
View(dados_clientes$Escolaridade)
str(dados_clientes$Escolaridade)
summary(dados_clientes$Escolaridade)

#Estado Civil
str(dados_clientes$Estado_Civil)
summary(dados_clientes$Estado_Civil)
dados_clientes$Estado_Civil <-cut(dados_clientes$Estado_Civil,
                                  c(-1,0,1,2,3),
                                  labels = c("Desconhecido",
                                             "Casado",
                                             "Solteiro",
                                             "OUtro"))
View(dados_clientes$Estado_Civil)
str(dados_clientes$Estado_Civil)
summary(dados_clientes$Estado_Civil)


#Convertendo a variável para o tipo fator com faixa etária
str(dados_clientes$Idade)
summary(dados_clientes$Idade)
hist(dados_clientes$Idade)
dados_clientes$Idade <-cut(dados_clientes$Idade,
                                  c(0,30,50,100),
                                  labels = c("Jovem",
                                             "|Adulto",
                                             "Idoso"))
                                           
View(dados_clientes$Idade)
str(dados_clientes$idade)
summary(dados_clientes$Idade)

View(dados_clientes)

#Convertendo a variavel que indica pagamentos para o tipo fator
dados_clientes$PAY_0 <- as.factor(dados_clientes$PAY_0)
dados_clientes$PAY_2 <- as.factor(dados_clientes$PAY_2)
dados_clientes$PAY_3 <- as.factor(dados_clientes$PAY_3)
dados_clientes$PAY_4 <- as.factor(dados_clientes$PAY_4)
dados_clientes$PAY_5 <- as.factor(dados_clientes$PAY_4)
dados_clientes$PAY_6 <- as.factor(dados_clientes$PAY_6)

# Aqui mudamos o tipo de variaveis para o tipo factor, estava tipo inteiro.
#virou variavel Qualitativa

#dataset após as conversões
str(dados_clientes)
sapply(dados_clientes,function(x) sum(is.na(x)))
missmap(dados_clientes, main = "Valores Missing observados")
dados_clientes <- na.omit(dados_clientes)
missmap(dados_clientes,main = "Valores Missing Observados")
dim(dados_clientes)
View(dados_clientes)

#Alterando a variável depedente para o tipo fator
str(dados_clientes$inadiplente)   # Aqui damos uma olhada de qual tipo é a variável no momento
colnames(dados_clientes)   #Vemos os nomes das colunas
dados_clientes$inadiplente <- as.factor(dados_clientes$inadiplente) # Aqui fazemos a mudança do tipo da variável para fator
str(dados_clientes$inadiplente) # Olhamos novamente o tipo da variavel (Após a alteração)
View(dados_clientes) #Vemos os dados

#Total de inadimplentes versus não-inadimplentes
?table
table(dados_clientes$inadiplente)
#Calculamos os numero de Inadimplentes com os não-inamdiplentes

#Vejamos as porcetagens entre as classes
prop.table(table (dados_clientes$inadiplente))
#Aqui vimos a propoção em porcetagens

#Compararando as classes com um gráfico usando ggplot2
qplot(inadimplente, data = dados_clientes, geom = "bar") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Set seed
set.seed(12345)









#Amostragem estrattificada
#Seleciona as linhas de acordo com a variavel inadimplente como strata
?createDataPartition
indice <- createDataPartition(dados_clientes$inadiplente, p = 0.75, list = FALSE)
dim(indice)


# Tudo que fizemos aqui foi manipulação de dados


####################### Modelo dde Machine Learning####################

?RandomForest
modelo_v1 <- randomForest(inadiplente ~ ., data = dados_clientes)


