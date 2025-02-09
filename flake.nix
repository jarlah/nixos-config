{
  description = "ymatsiuk NixOS configuration";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
            home-manager.users.jarlandre = { ... }: {
              imports = [
                "${inputs.impermanence}/home-manager.nix"
                ./home/starship.nix
                ./home/zsh.nix
                ./home/packages.nix
              ];
              programs.home-manager.enable = true;
            };
            home-manager.users.jarlah = { ... }: {
              imports = [
                "${inputs.impermanence}/home-manager.nix"
                ./home/starship.nix
                ./home/zsh.nix
                ./home/packages.nix
              ];
              programs.home-manager.enable = true;
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
