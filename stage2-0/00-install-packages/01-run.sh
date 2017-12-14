#!/bin/bash -e

install -m 644 files/etc/dnsmasq.conf ${ROOTFS_DIR}/etc/dnsmasq.conf
install -m 644 files/etc/network/interfaces ${ROOTFS_DIR}/etc/network/interfaces
install -m 644 files/etc/hostapd/hostapd.conf ${ROOTFS_DIR}/etc/hostapd/hostapd.conf

ln -sf nodejs ${ROOTFS_DIR}/usr/bin/node

echo "10.10.10.10     local.headlesspi.org" >> ${ROOTFS_DIR}/etc/hosts

touch ${ROOTFS_DIR}/boot/ssh

install -m 755 files/etc/init.d/create-uap0 ${ROOTFS_DIR}/etc/init.d/create-uap0
on_chroot << EOF
update-rc.d create-uap0 defaults
EOF
