{
  description = "ymatsiuk NixOS configuration";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs: {

    nixosConfigurations = {
      nixps = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          inputs.nixos-hardware.nixosModules.dell-xps-13-9310
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jarlandre = import ./home-manager.nix;
            home-manager.users.work = import ./home-manager.nix;
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
