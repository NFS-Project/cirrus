#sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Spark-Rom/manifest -b pyro -g default,-mips,-darwin,-notdefault
git clone https://github.com/NFS-Project/local_manifest --depth 1 -b rosy-SparkOS-13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source $CIRRUS_WORKING_DIR/config
timeStart

. build/envsetup.sh
export TZ=Asia/Jakarta
export BUILD_USERNAME=rosy
export BUILD_HOSTNAME=nfsproject
lunch spark_rosy-userdebug
mkfifo reading # Jangan di Hapus
tee "${BUILDLOG}" < reading & # Jangan di Hapus
build_message "Building Started" # Jangan di Hapus
progress & # Jangan di Hapus
mka bacon -j8  > reading & sleep 95m # Jangan di hapus text line (> reading)

retVal=$?
timeEnd
statusBuild
# end
