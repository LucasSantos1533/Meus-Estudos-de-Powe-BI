#Estatística Bássica

#Parte 4 - Tabela de Frequência

#Definindo a pasta de trabalho

setwd("C:/PowerBI/Cap12")
getwd()

#Carregando os dados
dados <- read.table("Usuarios.csv",
                    dec = ".",           #Separador de decimal
                    sep = ",",           #Separador de Coluna
                    h = T,               # H -> Header| T-> True -> Quer dizer que considere a primeira linha como cabeçalho
                    fileEncoding = "windows-1252")


#Visualizando e Sumarizando os dados
View(dados)    #Resumo tabela toda
names(dados)  #Visualizar os nomes das colunas
str(dados)    # resumo dos tipos de dados
summary(dados$salario)       #resumo das estátisticas
summary(dados$grau_instrucao)  #Informação da variavel especifica
mean(dados$salario)  #função calcula média da variavel salario
mean(dados$grau_instrucao)


#criando Tabela de Frequência Absolutas
freq <- table(dados$grau_instrucao)
View(freg)

#tabela de frequências Relativas
freq_rel <- prop.table(freq)
View(freq_rel)
