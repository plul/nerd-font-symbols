NERD_FONT_VERSION := "v3.2.1"

_list:
    @just --list --unsorted

# Check project
check:
    just --unstable --fmt --check
    nix fmt -- --check .
    taplo fmt --check `fd --extension=toml`
    prettier --check `fd --extension=md`
    cargo fmt -- --check 
    cargo clippy --tests --examples -- -D warnings
    taplo lint `fd --extension=toml`
    RUSTDOCFLAGS='-Dwarnings' cargo doc --no-deps
    cargo nextest run
    nix flake show

# Format code
fmt:
    just --unstable --fmt
    nix fmt
    taplo fmt `fd --extension=toml`
    cargo fmt
    prettier --write `fd --extension=md`

# Generate modules from specified NERD_FONT_VERSION
update:
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_cod.sh | cargo run -p generator > crates/nerd-font-symbols/src/cod.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_dev.sh | cargo run -p generator > crates/nerd-font-symbols/src/dev.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_fa.sh | cargo run -p generator > crates/nerd-font-symbols/src/fa.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_fae.sh | cargo run -p generator > crates/nerd-font-symbols/src/fae.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_iec.sh | cargo run -p generator > crates/nerd-font-symbols/src/iec.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_logos.sh | cargo run -p generator > crates/nerd-font-symbols/src/logos.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_md.sh | cargo run -p generator > crates/nerd-font-symbols/src/md.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_oct.sh | cargo run -p generator > crates/nerd-font-symbols/src/oct.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_ple.sh | cargo run -p generator > crates/nerd-font-symbols/src/ple.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_pom.sh | cargo run -p generator > crates/nerd-font-symbols/src/pom.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_seti.sh | cargo run -p generator > crates/nerd-font-symbols/src/seti.rs
    curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/{{ NERD_FONT_VERSION }}/bin/scripts/lib/i_weather.sh | cargo run -p generator > crates/nerd-font-symbols/src/weather.rs
    cargo fmt
