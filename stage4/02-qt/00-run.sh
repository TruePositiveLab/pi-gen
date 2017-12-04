#!/bin/bash -e

tar xvf files/qt-5.8.0-omx.tar.gz -C ${ROOTFS_DIR}/opt
tar xvf files/qtdeps.tar --strip-components=1 -C ${ROOTFS_DIR}/opt/qt
echo "/opt/qt/lib" > ${ROOTFS_DIR}/etc/ld.so.conf.d/qt58.conf
on_chroot ldconfig
install -m 644 files/qt.conf ${ROOTFS_DIR}/usr/bin/

