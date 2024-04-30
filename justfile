NERD_FONT_VERSION := "v3.2.1"

_list:
    @just --list --unsorted

# Check project
check:
    just check-fmt
    just test
    just lint
    just check-docs
    just check-nix

# Test project
test:
    cargo test

# Lint project
lint:
    just lint-rust
    just lint-toml

# Lint Rust
lint-rust:
    cargo clippy --tests --examples -- -D warnings

# Lint TOML
lint-toml:
    fd --extension=toml -X taplo lint

# Check documentation
check-docs:
    RUSTDOCFLAGS='-Dwarnings' cargo doc --no-deps

# Check Nix
check-nix:
    nix flake check

# Check formatting
check-fmt:
    just check-fmt-just
    just check-fmt-nix
    just check-fmt-toml
    just check-fmt-rust
    just check-fmt-markdown

# Check formatting of justfile
check-fmt-just:
    just --unstable --fmt --check

# Check formatting of Nix
check-fmt-nix:
    fd --extension=nix -X nixfmt --check

# Check formatting of TOML
check-fmt-toml:
    fd --extension=toml -X taplo fmt --check

# Check formatting of Rust
check-fmt-rust:
    cargo fmt -- --check

# Check formatting of Markdown
check-fmt-markdown:
    fd --extension=md -X prettier --check

# Format project
fmt:
    just fmt-just
    just fmt-nix
    just fmt-toml
    just fmt-rust
    just fmt-markdown

# Format Justfile
fmt-just:
    just --unstable --fmt

# Format Nix
fmt-nix:
    fd --extension=nix -X nixfmt

# Format TOML
fmt-toml:
    fd --extension=toml -X taplo fmt

# Format Rust
fmt-rust:
    cargo fmt

# Format Markdown
fmt-markdown:
    fd --extension=md -X prettier --write

# Generate modules from specified NERD_FONT_VERSION
update:
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_cod.sh     | cargo run -p generator > crates/nerd-font-symbols/src/cod.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_dev.sh     | cargo run -p generator > crates/nerd-font-symbols/src/dev.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_fa.sh      | cargo run -p generator > crates/nerd-font-symbols/src/fa.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_fae.sh     | cargo run -p generator > crates/nerd-font-symbols/src/fae.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_iec.sh     | cargo run -p generator > crates/nerd-font-symbols/src/iec.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_logos.sh   | cargo run -p generator > crates/nerd-font-symbols/src/logos.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_md.sh      | cargo run -p generator > crates/nerd-font-symbols/src/md.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_oct.sh     | cargo run -p generator > crates/nerd-font-symbols/src/oct.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_ple.sh     | cargo run -p generator > crates/nerd-font-symbols/src/ple.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_pom.sh     | cargo run -p generator > crates/nerd-font-symbols/src/pom.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_seti.sh    | cargo run -p generator > crates/nerd-font-symbols/src/seti.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_weather.sh | cargo run -p generator > crates/nerd-font-symbols/src/weather.rs
    cargo fmt

# Update flake inputs
update-flake-inputs:
    nix flake update
