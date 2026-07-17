# -------- Stage 1: Base Build --------
FROM osrf/ros:jazzy-desktop-full

# Setup environment
ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Create user first so we can install packages as the user
ARG USERNAME=turtle
ARG USER_UID=1111
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && mkdir /home/${USERNAME}/.config \
    && chown ${USER_UID}:${USER_GID} /home/${USERNAME}/.config \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Switch to non-root user
USER $USERNAME

# Copy requirement files and install dependencies
COPY docker/requirements.txt .
RUN sudo apt-get update \
    && sudo apt-get install --no-install-recommends -y $(cat requirements.txt) \
    && sudo rm -rf /var/lib/apt/lists/* \
    && sudo rm requirements.txt

# Create workspace directory
RUN mkdir -p /home/${USERNAME}/ros2_ws/src \
    && chown -R ${USER_UID}:${USER_GID} /home/${USERNAME}/ros2_ws

# Adds to bashrc the ros humble overlay sourcing.
RUN echo "source /opt/ros/jazzy/setup.bash" >> /home/${USERNAME}/.bashrc
# Adds colcon autocomplete
RUN echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> /home/${USERNAME}/.bashrc

WORKDIR /home/${USERNAME}/ros2_ws
CMD [ "/usr/bin/bash" ]
