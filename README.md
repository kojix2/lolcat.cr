# lolcat

[![build](https://github.com/kojix2/lolcat.cr/actions/workflows/build.yml/badge.svg)](https://github.com/kojix2/lolcat.cr/actions/workflows/build.yml)

Crystal implementation of the [lolcat](https://github.com/busyloop/lolcat).

- Animation is not supported yet.

## Installation

Download from [GitHub Release](https://github.com/kojix2/lolcat.cr/releases)

From source code:

```
git clone https://github.com/kojix2/lolcat.cr
cd lolcat.cr
shards build --release
mv bin/lolcat /usr/local/bin/ # or any directory in your PATH
```

## Usage

CLI

```
lolcat README.md
```

```
lolcat --help
```

As a library

See [examples](examples/)

## Development

Purpose:

This project was created as a template or sample for creating a command line tool.
It uses only standard libraries and is very simple in its mechanics.

## Contributing

Pull requests and issues are welcome.

## License

The original lolcat is licensed under the BSD 3-Clause "New" or "Revised" License
So this project is also licensed under the same license.
