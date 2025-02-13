NERD_FONT_VERSION := "v3.3.0"

_list:
    @just --list --unsorted

# Check project
check:
    bc-check
    cargo test
    RUSTDOCFLAGS='-Dwarnings' cargo doc --no-deps

# Format project
fmt:
    bc-fmt

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
