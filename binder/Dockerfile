FROM ghcr.io/epicgames/unreal-engine:dev-4.27

USER root
# Install basic requirements
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    software-properties-common \
    sudo locales apt-utils clang wget \
    build-essential procps curl file tzdata \
    python3-pip \
    curl \
    gedit \
    gnupg2 \
    sharutils \
    lsb-release \
    gettext-base \
    keyboard-configuration && \
    add-apt-repository ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Enable sudo for all users 
RUN echo 'ALL ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY ade/env.sh /etc/profile.d/ade_env.sh
COPY ade/entrypoint /tmp/ade_entrypoint

ENTRYPOINT ["/tmp/ade_entrypoint"]
CMD ["/bin/sh", "-c", "trap 'exit 147' TERM; tail -f /dev/null & wait ${!}"]
