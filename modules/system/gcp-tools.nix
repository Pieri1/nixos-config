{ config, pkgs, ... }:

{
  # Google Cloud Platform tools
  environment.systemPackages = with pkgs; [
    # --- GCP CLI ---
    google-cloud-sdk      # gcloud, gsutil, bq

    # --- Kubernetes e container orchestration ---
    kubectl               # Gerenciar GKE
    helm                  # Package manager Kubernetes

    # --- Infraestrutura como Código ---
    terraform             # Provisionar recursos GCP

    # --- API Testing ---
    grpcurl               # Cliente CLI para gRPC
    buf                   # Gerenciador de proto files
  ];

  # Variáveis de ambiente para GCP
  environment.sessionVariables = {
    CLOUDSDK_PYTHON = "${pkgs.python3}/bin/python3";
  };
}
