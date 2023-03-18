FROM ubuntu:22.04

# Install basic requirements
RUN apt-get update && \
    echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    software-properties-common \
    sudo locales apt-utils clang wget git gnupg2 \
    build-essential procps curl file tzdata \
    python3-pip \
    curl \
    gedit \
    gnupg2 \
    sharutils \
    lsb-release \
    gettext-base \
    keyboard-configuration \
    libglu1-mesa-dev \
	pulseaudio \
    x11-xserver-utils \
	xdg-user-dirs && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin && \
    mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    wget https://developer.download.nvidia.com/compute/cuda/12.1.0/local_installers/cuda-repo-ubuntu2204-12-1-local_12.1.0-530.30.02-1_amd64.deb && \
    dpkg -i cuda-repo-ubuntu2204-12-1-local_12.1.0-530.30.02-1_amd64.deb && \
    cp /var/cuda-repo-ubuntu2204-12-1-local/cuda-*-keyring.gpg /usr/share/keyrings/ && \
    apt-get update && \
    apt-get -y install cuda && \
    apt-get -y install vulkan-tools && \
    rm -rf /var/lib/apt/lists/* cuda-repo-ubuntu2204-12-1-local_12.1.0-530.30.02-1_amd64.deb 

# Enable sudo for all users 
RUN echo 'ALL ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY ade/env.sh /etc/profile.d/ade_env.sh
COPY ade/entrypoint /tmp/ade_entrypoint

ENTRYPOINT ["/tmp/ade_entrypoint"]
CMD ["/bin/sh", "-c", "trap 'exit 147' TERM; tail -f /dev/null & wait ${!}"]
