#!/bin/bash -e

echo -e "i2c-dev\n" >> ${ROOTFS_DIR}/etc/modules
sed -i 's/#dtparam=i2c_arm=on/dtparam=i2c_arm=on/g' ${ROOTFS_DIR}/boot/config.txt
