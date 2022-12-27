#!/bin/bash
## VERIFICAÇÃO DE SERVIÇOS DO SISGP
## PARA RODAR EM ROTINA DE MANUTENÇÃO

# Verifica a opção passada
case "$1" in
  # Verifica o status dos serviços
  --verifica)
    echo "Verificando status dos serviços..."
    status_nginx=$(systemctl is-active nginx)
    echo "Status do serviço nginx: $status_nginx"
    status_freeradius=$(systemctl is-active freeradius)
    echo "Status do serviço freeradius: $status_freeradius"
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
    ;;
  # Opção inválida
  *)
    echo "Opção inválida. Use --verifica para verificar o status dos serviços, --ativar para ativar os serviços ou --parar para parar os serviços."
    exit 1
    ;;
esac
