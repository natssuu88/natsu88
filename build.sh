# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ArcaneOS/Arcane_manifest -b R -g default,-mips,-darwin,-notdefault
git clone https://github.com/natssuu88/local_manifest --depth 1 -b arcane-11 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

. build/envsetup.sh
export BUILD_USERNAME=$BUILD_USERNAME
export BUILD_HOSTNAME=$BUILD_HOSTNAME
lunch aosp_whyred-userdebug
mkfifo reading # Jangan di Hapus
tee "${BUILDLOG}" < reading & # Jangan di Hapus
build_message "Building Started" # Jangan di Hapus
progress & # Jangan di Hapus
mka bacon > reading & sleep 95m # Jangan di hapus text line (> reading)

retVal=$?
timeEnd
statusBuild
