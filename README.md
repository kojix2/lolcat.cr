# <div align="center">What?<div>

<div align="center"><img src="https://raw.githubusercontent.com/busyloop/lolcat/master/ass/nom.jpg"></div>

---

[![build](https://github.com/kojix2/lolcat.cr/actions/workflows/build.yml/badge.svg)](https://github.com/kojix2/lolcat.cr/actions/workflows/build.yml)

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

See [examples](examples/)

## Development

This project was created as an example of a command line tool.
Use only standard libraries and keep it simple.

## Contributing

Pull requests and issues are welcome.

## License

The original lolcat is licensed under the BSD 3-Clause "New" or "Revised" License.
Thus, the same is true for this project.
