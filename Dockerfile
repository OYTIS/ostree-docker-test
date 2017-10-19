FROM ubuntu:xenial
MAINTAINER Anton Gerasimov <anton@advancedtelematic.com>

ENV OSTREE_REV="6063bdb0130cd0dc099bbf509f90863af7b3f0c0"

# install dependencies

RUN apt-get update -qqy && \
    apt-get install -qqy build-essential bzip2 chrpath cpio diffstat gawk gcc-multilib git-core libsdl1.2-dev locales python3 qemu socat sudo texinfo unzip wget xterm inetutils-ping autoconf libgpgme11-dev libarchive-dev libcurl4-openssl-dev curl libtool bison liblzma-dev e2fslibs-dev libsoup2.4-dev libfuse-dev

   
# apt-get clean && \
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib

RUN git clone https://github.com/ostreedev/ostree.git ostree-git && \
    cd ostree-git && \
    git checkout ${OSTREE_REV} && \
    NOCONFIGURE=1 ./autogen.sh && \
    ./configure --with-libarchive --disable-gtk-doc --disable-gtk-doc-html --disable-gtk-doc-pdf --disable-man --with-smack --with-builtin-grub2-mkconfig --with-curl --enable-wrpseudo-compat && \
    make -j8 && \
    make install

ADD scripts/makephysical.sh /usr/local/bin
ADD scripts/makedeployed.sh /usr/local/bin
CMD ["bash", "-C", "makephysical.sh", "/ostree-test"]
