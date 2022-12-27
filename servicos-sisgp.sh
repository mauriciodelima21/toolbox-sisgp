#!/bin/bash

# Verifica a opção passada
case "$1" in
  # Verifica o status dos serviços
  --verifica)
    echo "Verificando status dos serviços..."
    status_nginx=$(systemctl is-active nginx)
    echo "Status do serviço nginx: $status_nginx"
    status_freeradius=$(systemctl is-active freeradius)
    echo "Status do serviço freeradius: $status_freeradius"
    status_mariadb=$(systemctl is-active mariadb)
    echo "Status do serviço mariadb: $status_mariadb"
    status_sisgp=$(systemctl is-active sisgp)
    echo "Status do serviço sisgp: $status_sisgp"
    ;;
    # Ativa os serviços
 
  --ativar)
    echo "Ativando serviços..."
    if systemctl is-active nginx | grep -q 'inactive'; then
      systemctl start nginx
      echo "Serviço nginx ativado com sucesso"
    fi
    if systemctl is-active freeradius | grep -q 'inactive'; then
      systemctl start freeradius
      echo "Serviço freeradius ativado com sucesso"
    fi
    if systemctl is-active mariadb | grep -q 'inactive'; then
      systemctl start mariadb
      echo "Serviço mariadb ativado com sucesso"
    fi
    if systemctl is-active sisgp | grep -q 'inactive'; then
      systemctl start sisgp
      echo "Serviço sisgp ativado com sucesso"
    fi
    ;;
 
# Para os serviços
  --parar)
    echo "Parando serviços..."
    if systemctl is-active nginx | grep -q 'active'; then
      systemctl stop nginx
      echo "Serviço nginx parado com sucesso"
    fi
    if systemctl is-active freeradius | grep -q 'active'; then
      systemctl stop freeradius
      echo "Serviço freeradius parado com sucesso"
    fi
    if systemctl is-active mariadb | grep -q 'active'; then
      systemctl stop mariadb
      echo "Serviço mariadb parado com sucesso"
    fi
    if systemctl is-active sisgp | grep -q 'active'; then
      systemctl stop sisgp
      echo "Serviço sisgp parado com sucesso"
    fi
    ;;
  # Exibe a ajuda
  --ajuda|-h)
    echo "Uso: servicos-sisgp.sh [OPÇÃO]"
    echo "Opções disponíveis:"
    echo "  --verifica   Verifica o status dos serviços"
    echo "  --ativar     Ativa os serviços que estiverem parados"
    echo "  --parar      Para todos os serviços que estiverem ativos"
    echo "  --ajuda,-h   Exibe esta mensagem de ajuda"
    exit 0
    ;;
  # Opção inválida
  *)
    echo "Opção inválida. Use --ajuda ou -h para exibir a lista de opções disponíveis."
    exit 1
    ;;
esac

exit 0
