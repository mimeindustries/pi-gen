#!/bin/bash -e

ln -sf nodejs ${ROOTFS_DIR}/usr/bin/node

on_chroot << EOF
systemctl enable headlesspi
EOF

