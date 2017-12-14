#!/bin/bash -e

install -m 644 files/headlesspi.list ${ROOTFS_DIR}/etc/apt/sources.list.d/

on_chroot apt-key add - < files/mime-key.pub.gpg

on_chroot << EOF
apt-get update
EOF

