
#Criar diretorio com nome do usuario digitado
echo Criando diretorio home...
mkdir /home/$1

#Adicionar os arquivos de skel para dentro do diretorio do usuario
echo Copiando arquivos...
cp -R /etc/skel/ /home/$1

echo Adicionando configuracoes...
#Adicionar linha referente ao novo usuario em /etc/passwd
echo "$1:x:$userID:$groupID:$1,,,:/home/$1:/bin/bash" >> /etc/passwd

#Adicionar linha referente ao novo grupo de usuario em /etc/passwd
echo "$1:x:$groupID:" >> /etc/group

#Verificar se o usuario digitou a opção para inserir senha
#Se sim, senha deverá ser inserida
if test "$2" == "-s"
then
	passwd $1
else
	#Caso senha nao seja inserida, o usuario nao terá senha
	timestamp=`date +%s`
	days=$((timestamp / 86400))
	echo $1"::$days:0:99999:7:::" >> /etc/shadow
fi

#Atribuir propriedade a /home/$1 para o usuario criado
chown $1: /home/$1

