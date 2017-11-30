#/bin/bash -e

export REROTOR_SRC=/src/retailrotor
export REROTORNG_SRC=${REROTOR_SRC}/ReRotor-NG

mkdir /tmp/rerotor

cd /tmp/rerotor

cmake ${REROTORNG_SRC} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
    -DPRODUCTION=ON \
    -DONLY_VIDEO=ON \
    -DCMAKE_INSTALL_PREFIX=${ROOTFS_DIR}/usr

make -j4 install

install -D /opt/rpi/rootfs/usr/lib/libthrift* ${ROOTFS_DIR}/usr/lib
