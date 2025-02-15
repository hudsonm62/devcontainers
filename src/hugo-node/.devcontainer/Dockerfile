FROM golang:${templateOption:golangVersion}

ARG HUGO_VARIANT=${templateOption:hugoVariant}
ARG HUGO_VERSION=${templateOption:hugoVersion}
ARG NODE_VERSION=${templateOption:nodeVersion}

ARG TEMP_DIR=/tmp
ARG NODESOURCE_PATH=${TEMP_DIR}/nodesource_setup.sh

# non-root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN \
    #
    # Pull Correct Architecture for Hugo
    ## warning: mostly untested outside on arm
    ARCH=$(dpkg --print-architecture) && \
    HUGOPKG=${HUGO_VARIANT}_${HUGO_VERSION}_linux-${ARCH}.deb && \
    HUGOPKG_PATH=${TEMP_DIR}/${HUGOPKG} && \
    #
    # Install git, sudo, wget
    apt-get update && apt-get -y install  \
        git sudo wget \
    #
    # Install Hugo
    && wget -qO ${HUGOPKG_PATH} https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGOPKG} \
    && dpkg -i ${HUGOPKG_PATH} \
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

USER vscode
