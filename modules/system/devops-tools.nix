{ config, pkgs, ... }:

{
  # DevOps e ferramentas de containerização
  environment.systemPackages = with pkgs; [
    # --- Containerização ---
    docker                # Container runtime
    docker-compose        # Orquestração multi-container

    # --- Kubernetes local ---
    kind                  # Rodar cluster K8s localmente
    skaffold              # Desenvolvimento local com Kubernetes

    # --- Utilitários essenciais ---
    jq                    # Parser JSON
    yq                    # Parser YAML
    tmux                  # Multiplexer de terminal

    # --- Segurança ---
    openssl               # TLS/SSL
  ];

  # Permissão para Docker
  users.users.pieri.extraGroups = [ "docker" ];
  virtualisation.docker.enable = true;
}
