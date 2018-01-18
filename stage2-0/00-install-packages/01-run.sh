#!/bin/bash -e

install -m 644 files/etc/dnsmasq.conf ${ROOTFS_DIR}/etc/dnsmasq.conf
install -m 644 files/etc/network/interfaces ${ROOTFS_DIR}/etc/network/interfaces
install -m 644 files/etc/hostapd/hostapd.conf ${ROOTFS_DIR}/etc/hostapd/hostapd.conf
install -m 644 files/etc/cron.d/checkwlan0 ${ROOTFS_DIR}/etc/cron.d/checkwlan0
install -m 744 files/usr/local/bin/check-wlan0.sh ${ROOTFS_DIR}/usr/local/bin/check-wlan0.sh

echo "10.10.10.10     local.headlesspi.org" >> ${ROOTFS_DIR}/etc/hosts

touch ${ROOTFS_DIR}/boot/ssh

on_chroot << EOF
systemctl disable dhcpcd
systemctl disable hostapd
systemctl disable dnsmasq
EOF
