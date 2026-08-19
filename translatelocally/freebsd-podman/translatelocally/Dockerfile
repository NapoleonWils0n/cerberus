#===============================================================================
# FILE: Dockerfile
# Project: translatelocally-nix
#===============================================================================


#===============================================================================
# Inherit from nix
#===============================================================================

FROM nixos/nix:latest


#===============================================================================
# freebsd host user passed on the command line
#===============================================================================

ARG HOST_UID
ARG HOST_USER


#===============================================================================
# Create a non-root user and group
#===============================================================================

RUN mkdir -p /home/${HOST_USER} && \
    # Append GIDs matching FreeBSD host (wheel:*:0, video:44, realtime:47, pulse:563, pulse-rt:557, nix-users:30000)
    echo "video:x:44:${HOST_USER}" >> /etc/group && \
    echo "realtime:x:47:${HOST_USER}" >> /etc/group && \
    echo "pulse:x:563:${HOST_USER}" >> /etc/group && \
    echo "pulse-rt:x:557:${HOST_USER}" >> /etc/group && \
    echo "nix-users:x:30000:${HOST_USER}" >> /etc/group && \
    # Primary user group
    echo "${HOST_USER}:x:${HOST_UID}:" >> /etc/group && \

    # Add user entry to /etc/passwd
    echo "${HOST_USER}:x:${HOST_UID}:${HOST_UID}:${HOST_USER}:/home/${HOST_USER}:/bin/sh" >> /etc/passwd && \
    chown -R ${HOST_UID}:${HOST_UID} /home/${HOST_USER}

#===============================================================================
# Workspace directory
#===============================================================================

WORKDIR /home/${HOST_USER}
