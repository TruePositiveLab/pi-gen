#/bin/bash -e

export REROTOR_SRC=/src/retailrotor
export REROTORNG_SRC=${REROTOR_SRC}/ReRotor-NG

mkdir /tmp/rerotor

cd /tmp/rerotor

cmake ${REROTORNG_SRC} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
    -DPRODUCTION=ON \
    -DONLY_VIDEO=${ONLY_VIDEO:-ON} \
    -DCMAKE_INSTALL_PREFIX=${ROOTFS_DIR}/usr

make -j4 install

install -D /opt/rpi/rootfs/usr/lib/libthrift* ${ROOTFS_DIR}/usr/lib

export SYSTEMD_USER_DIR="${ROOTFS_DIR}/home/pi/.config/systemd/user/graphical-session.target.wants/"

install -D ${REROTORNG_SRC}/scripts/raspberry/timecorrection.{service,timer} ${ROOTFS_DIR}/etc/systemd/system
install -D ${REROTORNG_SRC}/scripts/raspberry/timecorrection.sh ${ROOTFS_DIR}/usr/bin

ln -s /etc/systemd/system/timecorrection.service ${ROOTFS_DIR}/etc/systemd/system/multi-user.target.wants/timecorrection.service
ln -s /etc/systemd/system/timecorrection.timer ${ROOTFS_DIR}/etc/systemd/system/timers.target.wants/timecorrection.timer

echo "systemctl --user start rerotord" >> ${ROOTFS_DIR}/home/pi/.profile
