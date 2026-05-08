{ config, pkgs, ... }:

{
  # Google Cloud SDK e ferramentas de nuvem
  environment.systemPackages = with pkgs; [
    # --- Google Cloud Platform ---
    google-cloud-sdk      # CLI oficial do GCP (gcloud, gsutil, bq)

    # --- Containerização e Orquestração ---
    docker                # Para rodar containers locais
    docker-compose        # Orquestração multi-container
    kubectl               # Gerenciar Kubernetes (GKE)
    helm                  # Package manager do Kubernetes
    skaffold              # Desenvolvimento local com Kubernetes
    kind                  # Rodar cluster K8s localmente (perfeito pra testes)

    # --- Infraestrutura como Código ---
    terraform             # IaC pra provisionar recursos GCP
    pulumi                # IaC alternativa (Python/Go/TS)

    # --- API Testing e Desenvolvimento ---
    grpcurl               # Cliente CLI pra testar gRPC APIs
    buf                   # Gerenciador de proto files
    # --- Utilitários Gerais ---
    jq                    # Parser JSON (essencial pra outputs do gcloud)
    yq                    # Parser YAML (pra arquivos Kubernetes/Terraform)
    fzf                   # Fuzzy finder (útil pra buscar projetos GCP)
    tmux                  # Multiplexer de terminal (pra estudar vários shells)

    # --- Segurança ---
    openssl               # TLS/SSL (certificados GCP)
  ];

  # Variáveis de ambiente úteis
  environment.sessionVariables = {
    CLOUDSDK_PYTHON = "${pkgs.python3}/bin/python3";
  };

  # Permissão para Docker (se for usar localmente)
  users.users.pieri.extraGroups = [ "docker" ];
  virtualisation.docker.enable = true;
}
