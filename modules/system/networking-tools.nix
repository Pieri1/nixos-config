{ config, pkgs, ... }:

{
  # 1. Wireshark Gráfico e Permissões Base
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark; 
  };

  users.users.pieri.extraGroups = [ "wireshark" ];

  # 2. O Arsenal de Terminal
  environment.systemPackages = with pkgs; [
    # --- Captura e Análise ---
    termshark   # A interface gráfica do Wireshark, mas feita para rodar dentro do terminal. Perfeito para abrir rápido num split de janela.
    tcpdump     # O clássico e imortal farejador de pacotes em modo texto.

    # --- Diagnóstico de Tráfego ---
    bandwhich   # Mostra em tempo real qual processo (ex: um app específico ou o sistema) está sugando sua banda no momento.
    mtr         # Junta o 'ping' e o 'traceroute' numa tela só, atualizando em tempo real. Ótimo para achar onde a internet está gargalando.

    # --- Mapeamento e APIs ---
    nmap        # O clássico escaneador de portas.
    rustscan    # Alternativa ao Nmap que escaneia todas as 65 mil portas em segundos.
    xh          # Uma alternativa ao 'curl' que formata respostas JSON com cores bonitas (ótimo se for testar APIs).
    
    # --- DNS e IPs ---
    dnsutils    # Traz o comando 'dig', essencial para ver como os domínios estão resolvendo.
    ipcalc      # Calculadora rápida de sub-redes e máscaras.
  ];
}