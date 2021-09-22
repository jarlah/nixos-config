{
  description = "ymatsiuk NixOS configuration";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs: {

    nixosConfigurations = {
      nixps = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          inputs.nixos-hardware.nixosModules.dell-xps-13-9310
          inputs.home-manager.nixosModules.home-manager
          inputs.impermanence.nixosModules.impermanence
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jarlandre = { pkgs, ... }: {
              imports = [
                "${inputs.impermanence}/home-manager.nix"
                ./home/starship.nix
                ./home/zsh.nix
              ];
              programs.home-manager.enable = true;
              programs.firefox.enable = true;
              programs.fzf.enable = true;
              programs.htop.enable = true;

              home.persistence."/nix/persist/home/jarlandre" = {
                directories = [ ".ssh" "Downloads" ".mozilla" ];
                files = [];
                allowOther = false;
              };
            };
            home-manager.users.work = { pkgs, ... }: {
              imports = [
                "${inputs.impermanence}/home-manager.nix"
                ./home/starship.nix
                ./home/zsh.nix
              ];
              programs.home-manager.enable = true;
              programs.firefox.enable = true;
              programs.fzf.enable = true;
              programs.htop.enable = true;

              home.persistence."/nix/persist/home/work" = {
                directories = [ ".ssh" "Downloads" ".mozilla" ];
                files = [];
                allowOther = false;
              };
            };
          }
          {
            config.nixpkgs = {
              config = { allowUnfree = true; };
            };
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
