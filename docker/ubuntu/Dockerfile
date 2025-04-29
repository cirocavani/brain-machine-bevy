FROM ubuntu:25.04
ARG USER_ID=1000
ARG GROUP_ID=1000

ENV DEBIAN_FRONTEND=noninteractive \
    PATH="/home/user/.cargo/bin:${PATH}"

RUN apt update && \
    apt install -y --no-install-recommends \
    ca-certificates \
    curl \
    sudo \
    clang \
    lld \
    pkg-config \
    libasound2-dev \
    libudev-dev \
    libx11-dev \
    libxkbcommon-x11-0 \
    libwayland-dev \
    libxkbcommon-dev \
    mesa-vulkan-drivers \
    mesa-utils \
    vulkan-tools && \
    apt distclean

RUN groupadd --gid ${GROUP_ID} user
RUN useradd -m --uid ${USER_ID} --gid ${GROUP_ID} -G sudo user
RUN passwd -d user
RUN echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/010_user-nopasswd

USER user
WORKDIR /home/user

RUN curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | \
    sh -s -- --default-toolchain stable -y

VOLUME ["/home/user/project", "/home/user/.cargo/registry", "/home/user/.cargo/git"]
WORKDIR /home/user/project

CMD ["/bin/bash", "-l"]
