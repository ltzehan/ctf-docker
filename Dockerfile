FROM debian:10.6

SHELL ["/bin/bash", "-c"]
USER root
RUN apt-get update && apt-get upgrade -y

# Install basic tools
RUN apt-get install -y \
    -o APT::Immediate-Configure=0 \
    \
    sudo libssl-dev libffi-dev build-essential \
    ltrace strace \
    openssl curl wget \
    unzip zip tar gzip \
    git cmake \
    zsh \
    neovim \
    htop ncdu hexyl \
    gdbserver tmux \
    python3 python3-dev python3-pip pypy3 pypy3-dev \
    ruby-full \
    \
    exiftool \
    binwalk \
    pngcheck \
    steghide \
    volatility \
    john

# Setup zsh
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)"

# Create user
RUN useradd -ms /bin/zsh qihao && \
    echo "# Run sudo without password" >> /etc/sudoers && \
    echo "qihao ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER qihao

WORKDIR /home/qihao
ENV HOME=/home/qihao

RUN sudo gem install \
    one_gadget \
    seccomp-tools

RUN pip3 install \
    pwntools \
    virtualenvwrapper
    
# Install rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="$HOME/.cargo/bin:${PATH}"
RUN cargo install vivid

# Install zsh pure
RUN mkdir ".zsh" && \
    git clone https://github.com/sindresorhus/pure.git ~/.zsh/pure

# Install gdb utilities
RUN git clone https://github.com/pwndbg/pwndbg ~/pwndbg && \
    git clone https://github.com/scwuaptx/Pwngdb.git ~/Pwngdb && \
    cd ~/pwndbg/ && \
    ./setup.sh

# Install pkcrack
RUN git clone https://github.com/keyunluo/pkcrack && \
    chmod +x ~/pkcrack/bin/pkcrack 
ENV PATH="$HOME/pkcrack/bin:${PATH}"

# Setup for virtualenv
ENV PATH="$HOME/.local/bin:${PATH}" \
    WORKON_HOME="$HOME/.virtualenv" \
    VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"

# Create angr env
RUN source $(which virtualenvwrapper.sh) && \
    mkvirtualenv --python=$(which pypy3) angr && \ 
    pypy3 -m pip install angr

# Install vim-plug
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    nvim --headless +PlugInstall +qall

# Run this near the end so we can hopefully hit more cached layers during build
COPY --chown=qihao:qihao dotfiles . 

# Install vim-plug plugins
RUN nvim --headless +PlugInstall +qall