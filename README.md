# <div align="center">What?<div>

<div align="center"><img src="https://raw.githubusercontent.com/busyloop/lolcat/master/ass/nom.jpg"></div>

---

[![build](https://github.com/kojix2/lolcat.cr/actions/workflows/build.yml/badge.svg)](https://github.com/kojix2/lolcat.cr/actions/workflows/build.yml)
[![Lines of Code](https://img.shields.io/endpoint?url=https%3A%2F%2Ftokei.kojix2.net%2Fbadge%2Fgithub%2Fkojix2%2Flolcat.cr%2Flines)](https://tokei.kojix2.net/github/kojix2/lolcat.cr)

:black_cat: Crystal implementation of the [lolcat](https://github.com/busyloop/lolcat)

## Installation

Download from [GitHub Release](https://github.com/kojix2/lolcat.cr/releases)

From source code:

```sh
git clone https://github.com/kojix2/lolcat.cr
cd lolcat.cr
shards build --release
mv bin/lolcat /usr/local/bin/ # or any directory in your PATH
```

Homebrew:

```sh
brew install kojix2/brew/lolcat
```

## Usage

```sh
lolcat README.md
```

```sh
lolcat --help
```

As a library

You can use lolcat.cr as a library in your Crystal projects:

```yaml
# Add to your shard.yml
dependencies:
  lolcat:
    github: kojix2/lolcat.cr
```

Basic usage:

```crystal
require "lolcat"

# Use the Lol module directly
include Lolcat::Lol

# Create options with default values
options = Lolcat::Options.new

# Apply rainbow colors to a string
colored_text = rainbow_line("Hello, colorful world!", options, 0.0)
puts colored_text

# Or process an entire IO stream
io = IO::Memory.new("Multiple\nLines\nOf\nText")
lol_cat(io, options)
```

For more examples, see [examples](examples/)

## Development

This project was created as an example of a command line tool.
Use only standard libraries and keep it simple.

## Contributing

Pull requests and issues are welcome.

## License

The original lolcat is licensed under the BSD 3-Clause "New" or "Revised" License.
Thus, the same is true for this project.
