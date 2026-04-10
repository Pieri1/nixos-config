{ config, pkgs, lib, ... }:

let
  obsidianVaultDir = "${config.home.homeDirectory}/documents/obsidian";
in
{
  home.packages = [
    pkgs.obsidian
    (pkgs.writeShellScriptBin "obsidian-vault" ''
      exec ${pkgs.obsidian}/bin/obsidian "${obsidianVaultDir}" "$@"
    '')
  ];

  home.sessionVariables = {
    OBSIDIAN_VAULT_DIR = obsidianVaultDir;
  };

  home.activation.ensureObsidianVaultDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${obsidianVaultDir}"
  '';
}
