{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem =
        {
          config,
          pkgs,
          system,
          lib,
          self',
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ (import inputs.rust-overlay) ];
          };

          packages = {
            rust-toolchain-stable = pkgs.rust-bin.stable.latest.minimal.override {
              extensions = [
                "rust-src"
                "clippy"
                "rust-analyzer"
              ];
            };

            rust-toolchain-nightly-minimal = pkgs.rust-bin.selectLatestNightlyWith (
              toolchain: toolchain.minimal
            );

            rustfmt-nightly = pkgs.rust-bin.selectLatestNightlyWith (
              toolchain: toolchain.minimal.override { extensions = [ "rustfmt" ]; }
            );
          };

          devShells.default = pkgs.mkShell {
            packages = [
              config.packages.rust-toolchain-stable
              config.packages.rustfmt-nightly
              pkgs.taplo
              pkgs.nodePackages.prettier
              pkgs.nixfmt-rfc-style
              pkgs.curl
            ];
          };
        };
    };
}
