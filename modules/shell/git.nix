{ config, pkgs, ... }:

{
	programs.git = {
		enable = true;
		userName = "Pieri1";
		userEmail = "joaopbs20111@gmail.com";

		extraConfig = {
			init.defaultBranch = "main";
			pull.rebase = true;
			push.autoSetupRemote = true;
			core.editor = "nvim";
		};

		ignores = [
			".DS_Store"
			"*.swp"
			".direnv/"
			"node_modules/"
			".vscode/"
			".env"
		];
	};
}
