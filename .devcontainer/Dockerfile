FROM debian:bookworm

ARG NODE_VERSION=22.x

ARG TEMP_DIR=/tmp
ARG NODESOURCE_PATH=${TEMP_DIR}/nodesource_setup.sh

# setup non root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN \
    #
    # Install git, sudo, wget
    apt-get update && apt-get -y install  \
        git sudo wget \
    #
    # Install Node from Nodesource
    && wget -qO ${NODESOURCE_PATH} https://deb.nodesource.com/setup_${NODE_VERSION} \
    && bash ${NODESOURCE_PATH} \
    && apt-get -y install nodejs \
    && npm install -g npm@latest \
    #
    # Cleanup
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf ${TEMP_DIR:?}/* \
    #
    # Create a non-root user to use - see https://aka.ms/vscode-remote/containers/non-root-user.
    && groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    # Add sudo support for the non-root user
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}
