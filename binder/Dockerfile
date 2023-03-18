FROM ghcr.io/nubonetics/ubuntu:22.04-vulkan

COPY  ./src/UnrealEngine /opt/UnrealEngine

RUN cd /opt/UnrealEngine && \
    ./Setup.sh && \
    rm .git && mkdir -p .git && \
    cd Engine && ./Build/BatchFiles/Linux/SetupToolchain.sh && cd .. && \
    ./GenerateProjectFiles.sh && \
    make && \
    chmod -R 777 /opt/UnrealEngine 
