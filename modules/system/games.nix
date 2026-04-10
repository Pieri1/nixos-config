{ config, pkgs, lib, ... }:

{
  # 1. Habilita a Steam com otimizações
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Abre portas para o Steam Remote Play
    dedicatedServer.openFirewall = true; # Abre portas para servidores dedicados
    localNetworkGameTransfers.openFirewall = true; # Transferência de jogos via rede local
  };

  # 2. Gamemode: Otimiza CPU, GPU e prioridade de processo ao jogar
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
        ioprio = 0;
        inhibit_screensaver = 1;
      };
    };
  };

  # 3. Gamescope: Micro-compositor para rodar jogos em resoluções customizadas ou HDR
  programs.gamescope.enable = true;

  # 4. Drivers de Vídeo e Aceleração de Hardware (Crucial para games)
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Necessário para a maioria dos jogos Steam (32 bits)
  };

  # 5. Melhor comportamento em sistemas com pouca RAM
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
  };

  # 6. Tunagens de kernel úteis para jogos
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.max_map_count" = 2147483642;
  };

  # 7. Pacotes auxiliares para a melhor experiência
  environment.systemPackages = with pkgs; [
    mangohud      # Overlay de FPS e temperatura (estilo o que você vê no Windows)
    protonup-qt   # Interface fácil para baixar o GE-Proton (essencial para rodar tudo)
    vulkan-tools  # Para testar se o driver vulkan está ok (vulkaninfo)
    winetricks    # Quebra-galho para dependências de jogos Windows
    lact
  ];

  # 8 Garante RADV no Vulkan quando lançar jogos
  environment.sessionVariables = {
    AMD_VULKAN_ICD = "RADV";
  };

  # 9 Remover/evitar governor fixo global:
  # powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  services.tlp = {
    enable = true;
    settings = {
      # Na tomada: performance
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      ENERGY_PERF_POLICY_ON_AC = "performance";
      PLATFORM_PROFILE_ON_AC = "performance";

      # Na bateria: economia
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      ENERGY_PERF_POLICY_ON_BAT = "power";
      PLATFORM_PROFILE_ON_BAT = "low-power";
    };
  };
}