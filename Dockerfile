FROM i386/debian:bullseye
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get -y install --no-install-recommends \
        git vim parted \
        quilt coreutils qemu-user-static debootstrap zerofree zip dosfstools \
        libarchive-tools libcap2-bin rsync grep udev xz-utils curl xxd file kmod bc \
        binfmt-support ca-certificates fdisk gpg pigz arch-test \
    && rm -rf /var/lib/apt/lists/*

COPY --from=multiarch/qemu-user-static:latest /usr/bin/qemu-arm-static /usr/bin/

COPY . /pi-gen/

VOLUME [ "/pi-gen/work", "/pi-gen/deploy"]
