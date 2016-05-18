#!/bin/bash

# Atividade: Criar um script que leia os dados de uma planilha e crie as contas para os usuarios.
# O script deve permitir desabilitar uma determinada conta ou uma lista de contas. 
# Deve também permitir consultar se uma conta existe no sistema.

# Armazena o arquivo na variável

function menu(){
# Criar menu
echo "1- Criar contas para usuários em arquivo .csv"
echo "2- Desabilitar contas em arquivo .csv"
echo "3- Consultar se conta existe no sistema"
echo "9- Sair"

while true 
do
echo ""
printf "Digite sua opção: "
read op
	case $op in
		1)	echo ""  	
			echo "Criar Contas:"
			criarContas2
		;;
		
		2) 	echo "" 
			echo "Desabilitar Contas"
		;;

		3)	echo "" 
			echo "Consultar se conta existe no sistema:"
		   	consultarSeUmaContaExisteNoSistema
		;;

		4) 	menu
		;;

		9) 	exit 1
		;;

		*) 	echo "Opção invalida"
		;;
	esac
done
}

function consultarSeUmaContaExisteNoSistema {
	printf "Digite o nome do usuário: "	
	read user
	
	echo ""
	if id $user
	then	
		echo "Usuário existente."
		echo ""
	else
		echo "Usuário inexistente."
		echo ""
	fi
}

function criarContas2() {
#printf "Digite o nome do arquivo .csv: "
#read INPUT

INPUT=planilha.csv

linhas=`wc -l $INPUT | cut -d " " -f 1`
linhas=$((linhas-1))

while IFS="," read f1 f2 f3 f4
do	
	echo "$f4"
	adduser "$f4" --force-badname
done < $INPUT
}

function criarContas {
#printf "Digite o nome do arquivo .csv: "
#read INPUT

INPUT=planilha.csv

# Altera o IFS pra ','
OLDIFS=$IFS
IFS=,

echo ""
[ ! -f $INPUT ] && { echo "$INPUT Arquivo CSV não encontrado"; }
while read -r Nome Funcao Curso Matricula
do
	if test "$Nome" == "Nome"
	then
		echo "Criando usuários:"
	else
		nomeDoUsuario=$Nome
		pass=123456
		grupo=$Funcao
		complemento=$Curso
		user=$Matricula

		#echo "Nome do usuário: $nomeDoUsuario"
		#echo "Password: $pass"
		#echo "Grupo: $grupo"
		#echo "Complemento: $nomeDoUsuario, $complemento"
		#echo "Usuario: $matricula"
		
		grupoTeste=`cat /etc/group | cut -d ':' -f 1 | grep $Funcao`	
		if test "$grupo" != "$grupoTeste" 
		then
			groupadd $grupo	
		fi

		adduser ${user} --force-badname
	fi		
done < $INPUT
#IFS=$OLDIFS
}

menu
