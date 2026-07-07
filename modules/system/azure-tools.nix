{ config, pkgs, ... }:

{
  # Microsoft Azure tools
  environment.systemPackages = with pkgs; [
    # --- Azure CLI ---
    azure-cli             # CLI oficial Azure

    # --- Infraestrutura como Código ---
    opentofu              # IaC livre (fork do Terraform)
    bicep                 # Linguagem IaC alternativa Azure
  ];

  # Variáveis de ambiente para Azure
  environment.sessionVariables = {
    AZURE_DEVOPS_EXT_PAT = "";  # Placeholder para token (user configura)
  };
}
