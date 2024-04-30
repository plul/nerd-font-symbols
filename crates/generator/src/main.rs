#![doc = env!("CARGO_PKG_DESCRIPTION")]

use std::{
    collections::BTreeMap,
    io::{self, BufRead},
};

use regex::Regex;

fn main() -> io::Result<()> {
    let re = Regex::new(r"^i='(\S)' i_(\S+)=\$i").unwrap();

    let mut symbols = BTreeMap::new();

    let stdin = io::stdin();

    for line in stdin.lock().lines() {
        let line = line?;
        if let Some(cap) = re.captures(&line) {
            let symbol = cap.get(1).unwrap().as_str().to_owned();
            let name = cap.get(2).unwrap().as_str().to_owned();
            symbols.insert(name, symbol);
        }
    }

    for (name, symbol) in symbols {
        println!("/// `{symbol}`");
        println!("pub const {}: &str = \"{symbol}\";", name.to_uppercase());
    }

    Ok(())
}
