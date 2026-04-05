# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Módulos de Pacotes Opicionais:
      ./modules/system/networking-tools.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [ 
    "quiet"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "boot.shell_on_fail"
    "usbcore.autosuspend=-1" 
    "psmouse.synaptics_intertouch=0" # Melhora compatibilidade de periféricos em laptops
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ohci_pci" "ehci_pci" "usbhid" "usb_storage" ];

  networking.hostName = "pieri-notebook"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.:
  time.timeZone = "America/Sao_Paulo";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };
  
  services.logind.settings = {
    Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
    };
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Habilita binario
  programs.zsh.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver.libinput.enable = true; # Garante drivers genéricos estáveis para o KVM
  xdg.portal = {
    
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pieri = {
    isNormalUser = true;
    description = "João Pieri";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "wireshark" ];
    packages = with pkgs; [];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    curl
    wget
    brightnessctl
  ];

  # docker
  virtualisation.docker.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # Comando limpo e direto
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Garante que o usuário do login tenha acesso ao vídeo
  users.extraUsers.greeter = {
    extraGroups = [ "video" "render" ];
  };

  #unfree software
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11"; # Did you read the comment?

}
