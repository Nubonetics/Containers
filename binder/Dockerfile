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

# Create an Installed Build of the Engine
# ref: https://github.com/EpicGames/UnrealEngine/blob/5.1.1-release/Engine/Extras/Containers/Dockerfiles/linux/dev/Dockerfile#L167
RUN cd /opt/UnrealEngine && \
    ./Engine/Build/BatchFiles/RunUAT.sh BuildGraph \
    -target="Make Installed Build Linux" \
    -script=Engine/Build/InstalledEngineBuild.xml \
    -set:HostPlatformOnly=true \
    -set:WithDDC=true \
    -set:WithLinuxArm64=false -set:WithClient=true -set:WithServer=true && \
	rm -R -f /home/ue4/UnrealEngine/LocalBuilds/InstalledDDC

# Perform first-run setup for Mono, UnrealBuildTool and AutomationTool, which makes it possible to build Unreal projects and plugins as users
# ref: https://github.com/EpicGames/UnrealEngine/blob/5.1.1-release/Engine/Extras/Containers/Dockerfiles/linux/dev/Dockerfile#L189
RUN cd /opt/UnrealEngine && \
  ./Engine/Build/BatchFiles/Linux/Build.sh UnrealHeaderTool Linux Development -SkipBuild && \
	mkdir -p ./Engine/Programs/AutomationTool/Saved

