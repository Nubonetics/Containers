FROM ghcr.io/nubonetics/ubuntu:22.04-vulkan

COPY  ./src/UnrealEngine /opt/UnrealEngine

RUN cd /opt/UnrealEngine && \
    ./Setup.sh \
		--exclude=Mac \
		--exclude=Win32 \
		--exclude=Win64 && \
    ./GenerateProjectFiles.sh && \
    make && \
    chmod -R 777 /opt/UnrealEngine 

RUN cd /opt/UnrealEngine && \ 
   ./Engine/Build/BatchFiles/Linux/Build.sh UnrealHeaderTool Linux Development -SkipBuild -buildubt

