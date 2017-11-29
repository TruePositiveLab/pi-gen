#!/bin/bash -e

tar xvf files/qt-5.8.0-omx.tar.gz -C ${ROOTFS_DIR}/opt
echo "/opt/qt/lib" > ${ROOTFS_DIR}/etc/ld.so.conf.d/qt58.conf
