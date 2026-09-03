use ferris_says::say;
use std::io::{BufWriter, stdout};

fn main() {
    let msg = "hello world! :D";
    let width = msg.chars().count();

    let mut writer = BufWriter::new(stdout().lock());
    say(&msg, width, &mut writer).unwrap();
}
