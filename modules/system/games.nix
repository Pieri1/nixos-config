{ config, pkgs, ... }:

{
  # 1. Habilita a Steam com otimizações
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Abre portas para o Steam Remote Play
    dedicatedServer.openFirewall = true; # Abre portas para servidores dedicados
    localNetworkGameTransfers.openFirewall = true; # Transferência de jogos via rede local
  };

  # 2. Gamemode: Otimiza CPU, GPU e prioridade de processo ao jogar
  programs.gamemode.enable = true;

  # 3. Gamescope: Micro-compositor para rodar jogos em resoluções customizadas ou HDR
  programs.gamescope.enable = true;

  # 4. Drivers de Vídeo e Aceleração de Hardware (Crucial para games)
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Necessário para a maioria dos jogos Steam (32 bits)
  };

  # 5. Pacotes auxiliares para a melhor experiência
  environment.systemPackages = with pkgs; [
    mangohud      # Overlay de FPS e temperatura (estilo o que você vê no Windows)
    protonup-qt   # Interface fácil para baixar o GE-Proton (essencial para rodar tudo)
    vulkan-tools  # Para testar se o driver vulkan está ok (vulkaninfo)
    winetricks    # Quebra-galho para dependências de jogos Windows
  ];
}