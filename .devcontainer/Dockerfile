FROM python:3.8

RUN apt update \
    && apt install -y sudo vim git \
    zip cloc zsh zsh-syntax-highlighting  \
    zsh-doc less software-properties-common

ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN pip install --upgrade pip

RUN pip install autopep8 ruamel.yaml pylint

# Install GitHub CLI
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0

RUN apt-add-repository https://cli.github.com/packages

RUN apt update && apt install -y gh

# Persist session history
RUN mkdir /commandhistory \
    && touch /commandhistory/.history \
    && chown -R $USERNAME commandhistory

USER $USERNAME

RUN cd ~/ && wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && sh install.sh --unattended && rm install.sh

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.history" \
    && echo $SNIPPET >> "/home/$USERNAME/.zshrc"
