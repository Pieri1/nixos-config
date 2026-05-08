{ config, pkgs, ... }:

{
  # Amazon Web Services tools
  environment.systemPackages = with pkgs; [
    # --- AWS CLI ---
    awscli2               # CLI oficial AWS

    # --- Infraestrutura como Código ---
    terraform             # IaC (compartilhado com GCP/Azure)

    # --- Utilitários AWS ---
    aws-vault             # Gerenciar credenciais AWS com segurança
  ];

  # Variáveis de ambiente para AWS
  environment.sessionVariables = {
    AWS_PAGER = "";       # Desabilitar paginação padrão
  };
}
