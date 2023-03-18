FROM ghcr.io/nubonetics/ubuntu:22.04-vulkan

COPY  ./src/UnrealEngine /opt/UnrealEngine

RUN cd /opt/UnrealEngine && \
    ./Setup.sh && \
    ./GenerateProjectFiles.sh && \
    make && \
    chmod -R 777 /opt/UnrealEngine 
