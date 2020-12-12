# ctf-docker

Had a WSL2 environment, messed that up. So now I have a containerized CTF environment.

### Quick Start

Run with:

```sh
docker-compose run --rm ctf
```

As I need to sometimes use Windows-only tools, some files are mounted from host volumes to the container:

- CTF files placed in `./ctf/` can be found under `~/ctf/`
- Wordlists are mounted from `./wordlists` to `~/wordlists`

Might be kind of strange, but it works for me.

### General

Default shell is `zsh` running the [Pure theme](https://github.com/sindresorhus/pure). Also includes:

- neovim + [vim-plug](https://github.com/junegunn/vim-plug)
- [htop](https://htop.dev/) - Interactive process viewer
- [hexyl](https://github.com/sharkdp/hexyl) - Simple hex viewer
- [angr](https://github.com/angr/angr) (on PyPy)
  - Runs inside a virutal environment activated with `workon angr`

### Forensics

I also use [stego-toolkit](https://github.com/DominicBreuker/stego-toolkit), a far more comprehensive Docker image for forensics and [StegSolve](http://www.caesum.com/handbook/stego.htm). These are just a subset of tools that I use the most:

- exiftool
- binwalk
- pngcheck
- steghide
- [volatility](https://github.com/volatilityfoundation/volatility)
- [john](https://github.com/openwall/john) (Just the package, not bleeding-jumbo *yet*)
- [pkcrack](https://github.com/keyunluo/pkcrack)

### pwn

- gdb plugins
  - [pwndbg](https://github.com/pwndbg/pwndbg) 
  - [Pwngdb](https://github.com/scwuaptx/Pwngdb)
- [pwntools](https://github.com/Gallopsled/pwntools)
  - Also has tmux to leverage the windows splitting functionality from attaching gdb to a process
- [one_gadget](https://github.com/david942j/one_gadget)
- [seccomp-tools](https://github.com/david942j/seccomp-tools)