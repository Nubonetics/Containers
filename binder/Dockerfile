FROM osrf/ros:noetic-desktop-full-focal

# Install basic requirements
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    software-properties-common \
    sudo locales apt-utils clang wget git gnupg2 \
    build-essential procps file tzdata \
    python3-pip \
    curl \
    gnupg2 \
    sharutils \
    lsb-release \
    gettext-base \
    keyboard-configuration \
    libglu1-mesa-dev \
	pulseaudio \
    x11-xserver-utils \
	xdg-user-dirs \
    vulkan-tools && \
    rm -rf /var/lib/apt/lists/*

# Install Python requirements for PX4
RUN pip3 install kconfiglib jinja2 pyros-genmsg future

# Enable sudo for all users 
RUN echo 'ALL ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY ade/env.sh /etc/profile.d/ade_env.sh
COPY ade/entrypoint /tmp/ade_entrypoint

ENTRYPOINT ["/tmp/ade_entrypoint"]
CMD ["/bin/sh", "-c", "trap 'exit 147' TERM; tail -f /dev/null & wait ${!}"]
