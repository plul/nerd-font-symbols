{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      perSystem = {
        config,
        pkgs,
        system,
        lib,
        self',
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [(import inputs.rust-overlay)];
        };

        formatter = pkgs.alejandra;

        packages = {
          rust-toolchain =
            pkgs.rust-bin.stable.latest.default;
        };

        devShells.default = pkgs.mkShell {
          packages = [
            config.packages.rust-toolchain
            pkgs.rust-analyzer
            config.formatter
            pkgs.taplo
            pkgs.just
            pkgs.fd
            pkgs.cargo-nextest
            pkgs.nodePackages.prettier
            pkgs.curl
          ];
        };
      };
    };
}
