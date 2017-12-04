#!/bin/bash -e

export QT=qt-5.8.0-omx.tar.gz
export QTDEPS=qtdeps.tar

if [ ! -f files/$QT ]; then
    wget https://github.com/TruePositiveLab/pi-gen/releases/download/qt/$QT -O files/$QT
fi

if [ ! -f files/$QTDEPS ]; then
    wget https://github.com/TruePositiveLab/pi-gen/releases/download/qt/$QTDEPS -O files/$QTDEPS
fi

tar xvf files/$QT -C ${ROOTFS_DIR}/opt
tar xvf files/$QTDEPS --strip-components=1 -C ${ROOTFS_DIR}/opt/qt
echo "/opt/qt/lib" > ${ROOTFS_DIR}/etc/ld.so.conf.d/qt58.conf
on_chroot ldconfig
install -m 644 files/qt.conf ${ROOTFS_DIR}/usr/bin/

