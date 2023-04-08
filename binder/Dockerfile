FROM osrf/ros:noetic-desktop-full-focal

# Install basic requirements
RUN apt-get update && \
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

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
    mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    wget https://developer.download.nvidia.com/compute/cuda/11.0.3/local_installers/cuda-repo-ubuntu2004-11-0-local_11.0.3-450.51.06-1_amd64.deb && \
    dpkg -i cuda-repo-ubuntu2004-11-0-local_11.0.3-450.51.06-1_amd64.deb && \
    apt-key add /var/cuda-repo-ubuntu2004-11-0-local/7fa2af80.pub && \
    apt-get update && \
    apt-get -y install cuda && \
    apt-get -y install vulkan-tools && \
    rm -rf /var/lib/apt/lists/* cuda-repo-ubuntu2004-11-0-local_11.0.3-450.51.06-1_amd64.deb 

# Enable sudo for all users 
RUN echo 'ALL ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY ade/env.sh /etc/profile.d/ade_env.sh
COPY ade/entrypoint /tmp/ade_entrypoint

ENTRYPOINT ["/tmp/ade_entrypoint"]
CMD ["/bin/sh", "-c", "trap 'exit 147' TERM; tail -f /dev/null & wait ${!}"]
