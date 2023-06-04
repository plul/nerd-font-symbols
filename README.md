# Nerd Font Symbols

A `const <NAME>: &str = "<symbol>"` definition for each of the symbols in [Nerd Fonts](https://www.nerdfonts.com/).

## Usage

```toml
[dependencies]
nerd-font-symbols = "0.1"
```

```rust
assert_eq!(nerd_font_symbols::md::MD_PERIODIC_TABLE, "󰢶");
```
