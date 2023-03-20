FROM ghcr.io/nubonetics/ubuntu:22.04-vulkan

COPY  ./src/UnrealEngine /opt/UnrealEngine

# Build UnrealEngine
RUN cd /opt/UnrealEngine && \
    ./Setup.sh \
		--exclude=Mac \
		--exclude=Win32 \
		--exclude=Win64 && \
    ./GenerateProjectFiles.sh && \
    make 

# Ensure UBT is built before we create the Installed Build
# ref: https://github.com/EpicGames/UnrealEngine/blob/5.1.1-release/Engine/Extras/Containers/Dockerfiles/linux/dev/Dockerfile#L160
RUN cd /opt/UnrealEngine && \
   rm -rf .git && \
   ./Engine/Build/BatchFiles/Linux/Build.sh UnrealHeaderTool Linux Development -SkipBuild -buildubt
