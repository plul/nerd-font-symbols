{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    basecamp.url = "github:plul/basecamp";
    basecamp.inputs.nixpkgs.follows = "nixpkgs";
    basecamp.inputs.rust-overlay.follows = "rust-overlay";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ basecamp, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem =
        {
          pkgs,
          ...
        }:
        let
          basecampConfig = {
            rust.enable = true;
            rust.packages.cargo-udeps.enable = true;
          };
        in
        {
          devShells.default = basecamp.mkShell pkgs basecampConfig // {
            packages = [
              pkgs.curl
            ];
          };
        };
    };
}
