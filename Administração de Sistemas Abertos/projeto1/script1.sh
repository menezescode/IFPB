#!/bin/bash

#Atividade: Criar um script que leia os dados de uma planilha e crie as contas para os usuarios.
#O script deve permitir desabilitar uma determinada conta ou uma lista de contas. 
#Deve também permitir consultar se uma conta existe no sistema.

#Recebendo número de linhas e subtraindo 1 para eliminar a primeira linha que contem
#o cabeçalho atribuindo o resultado à variavel linhas.
linhas=`wc -l planilha.csv`
linhas=${linhas:0:1}
linhas=$((linhas - 1))

NUMLINHA=$linhas
echo $numlinhas

echo "O numero de linhas é: $linhas"
echo --------------------
for i in {0..$numlinhas..1}
do
	cat "planilha.csv" | grep -n ^ | grep ^$i
done

