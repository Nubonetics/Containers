FROM nvidia/vulkan:1.3-470

RUN rm /etc/apt/sources.list.d/cuda.list || true && \
    rm /etc/apt/sources.list.d/nvidia-ml.list || trueapt-key del 7fa2af80 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub

# Install basic requirements
RUN apt-get update && \
    echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
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
