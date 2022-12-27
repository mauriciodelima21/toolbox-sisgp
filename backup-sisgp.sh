#!/bin/bash

# VARIAVEIS
# diretórios que serão feito os backups
diretorios="/var/fluxus /opt /root/.ssh /etc/freeradius"
# usuário do banco de dados
usuariodb=root
#banco de dados que serão feito o backup
bancos="sisgp radius"
# diretorio de destino dos backups
diretoriobkp="/backups"

# verifica se o usuário é o root
if [ "$EUID" -ne 0 ]
  then echo "Este script deve ser executado como root."
  exit
fi

# verifica se foi informada alguma opção
if [ $# -eq 0 ]
  then echo "Informe uma opção: --completo, --arquivos ou --banco"
  exit
fi

# verifica qual opção foi informada
if [ "$1" == "--completo" ]
then
  # gera o nome do arquivo de backup
  data=$(date +%Y%m%d-%H%M%S)
  arquivo_bkp_arquivos="arquivos-$data.tar.gz"
  arquivo_bkp_banco="banco-$data.sql"
  arquivo_bkp_crontab="crontab-$data.txt"

  # realiza o backup dos diretórios e arquivos
  echo "Realizando o backup dos arquivos..."
  tar -zcvf "$diretoriobkp/$arquivo_bkp_arquivos" $diretorios

  # realiza o backup dos bancos de dados
  echo "Realizando o backup dos bancos de dados..."
  for banco in $bancos

  do
    mysqldump -u $usuariodb $banco > "$diretoriobkp/$banco-$data.sql"
  done

  # realiza o backup da crontab
  echo "Realizando o backup da crontab..."
  crontab -l > "$diretoriobkp/$arquivo_bkp_crontab"

elif [ "$1" == "--arquivos" ]
then
  # gera o nome do arquivo de backup
  data=$(date +%Y%m%d-%H%M%S)
  arquivo_bkp_arquivos="arquivos-$data.tar.gz"

  # realiza o backup dos diretórios e arquivos
  echo "Realizando o backup dos arquivos..."
  tar -zcvf "$diretoriobkp/$arquivo_bkp_arquivos" $diretorios

elif [ "$1" == "--banco" ]
then
  # gera o nome do arquivo de backup
  data=$(date +%Y%m%d-%H%M%S)

  # realiza o backup dos bancos de dados
  echo "Realizando o backup dos bancos de dados..."
  for banco in $bancos
  do
    mysqldump -u $usuariodb $banco > "$diretoriobkp/$banco-$data.sql"
  done

else
  echo "Opção inválida. Informe uma opção válida: --completo, --arquivos ou --banco"
fi

echo "Backup realizado com sucesso!"
