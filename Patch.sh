# HW/O
rm -rf hardware/oplus
git clone --depth=1 https://github.com/yaap/hardware_oplus -b fifteen hardware/oplus

# Shitpolicy
rm -rf device/qcom/sepolicy_vndr/sm8650
git clone --depth=1 https://github.com/yaap/device_qcom_sepolicy_vndr_sm8650 -b fifteen device/qcom/sepolicy_vndr/sm8650

# SM8650 Basic Support
rm -rf hardware/qcom-caf/sm8650/audio hardware/qcom-caf/sm8650/dataipa hardware/qcom-caf/sm8650/data-ipa-cfg-mgr hardware/qcom-caf/sm8650/display hardware/qcom-caf/sm8650/media
git clone --depth=1 https://github.com/yaap/vendor_qcom_opensource_agm-sm8650 hardware/qcom-caf/sm8650/audio/agm -b fifteen
git clone --depth=1 https://github.com/yaap/vendor_qcom_opensource_arpal-lx-sm8650 hardware/qcom-caf/sm8650/audio/pal -b fifteen
git clone --depth=1 https://github.com/yaap/hardware_qcom_audio-ar-sm8650 hardware/qcom-caf/sm8650/audio/primary-hal -b fifteen
git clone --depth=1 https://github.com/yaap/vendor_qcom_opensource_dataipa-sm8650 hardware/qcom-caf/sm8650/dataipa -b fifteen
git clone --depth=1 https://github.com/yaap/vendor_qcom_opensource_data-ipa-cfg-mgr-sm8650 hardware/qcom-caf/sm8650/data-ipa-cfg-mgr -b fifteen
git clone --depth=1 https://github.com/yaap/hardware_qcom-caf_sm8650_display hardware/qcom-caf/sm8650/display -b fifteen
git clone --depth=1 https://github.com/yaap/hardware_qcom-caf_sm8650_media hardware/qcom-caf/sm8650/media -b fifteen

# SM8650 Symlink
cd hardware/qcom-caf/sm8650
ln -sf ../common/os_pickup_qssi.bp Android.bp
ln -sf ../common/os_pickup.mk Android.mk
ln -sf ../../common/os_pickup_audio-ar.mk audio/Android.mk
cd ../../..

# SM8650 qcom-caf common ify
cd hardware/qcom-caf/common
if [[ ! $(cat BoardConfigQcom.mk | grep "UM_6_1_FAMILY") ]]; then
	wget https://raw.githubusercontent.com/OPACE3PRO/VendorBlobs/refs/heads/yaap-15/sm8650.patch
	patch -p1 < sm8650.patch
fi
if [[ $(cat compatibility_matrix.xml | grep "android.system.wifi.keystore") ]]; then
	wget https://github.com/yaap/hardware_qcom-caf_common/commit/de6a1a7565285513f10bcd12ec05a812493ce481.patch
	patch de6a1a7565285513f10bcd12ec05a812493ce481.patch
fi
rm -rf de6a1a7565285513f10bcd12ec05a812493ce481.patch sm8650.patch
cd ../../..

# SM8650 qcom-caf display ify
cd hardware/qcom-caf/sm8650/display
wget https://github.com/Xiaomi-SM8650/android_hardware_qcom_display/commit/9ac933328bae5b9d563af8a45ea27264aa08fd7c.patch
patch -p1 < 9ac933328bae5b9d563af8a45ea27264aa08fd7c.patch
rm -rf 9ac933328bae5b9d563af8a45ea27264aa08fd7c.patch
cd ../../../..

# SM8650 Soong ify
cd build/soong
if [[ ! $(cat android/arch_list.go | grep "kryo785") ]]; then
	wget https://github.com/yaap/build_soong/commit/1ad390cd69c9067c6333e3f16c2a87e8e12196a7.patch
	patch -p1 < 1ad390cd69c9067c6333e3f16c2a87e8e12196a7.patch
	rm -rf 1ad390cd69c9067c6333e3f16c2a87e8e12196a7.patch
fi
cd ../..

# SM8650 Hardware Interfaces ify
cd hardware/interfaces
if  [[ ! $(cat compatibility_matrices/compatibility_matrix.8.xml | grep "2.1-2") ]]; then
	wget https://github.com/yaap/hardware_interfaces/commit/9a798575bf5426a58e00aedff046dcac801686b3.patch
	patch -p1 < 9a798575bf5426a58e00aedff046dcac801686b3.patch
	rm -rf 9a798575bf5426a58e00aedff046dcac801686b3.patch
fi
cd ../..

# SM8650 Hardware Oplus ify
cd hardware/oplus
wget https://github.com/yaap/hardware_oplus/commit/85c0bbc3d11abb76b22063fe0c6ddc519b6fcef7.patch
patch -p1 -R < 85c0bbc3d11abb76b22063fe0c6ddc519b6fcef7.patch
rm -rf 85c0bbc3d11abb76b22063fe0c6ddc519b6fcef7.patch
cd ../..

# SM8650 Sepolicy_vndr ify
cd device/qcom/sepolicy_vndr/sm8650
wget https://raw.githubusercontent.com/OPACE3PRO/VendorBlobs/refs/heads/yaap-15/sm8650-sepolicy_vndr.patch
patch -p1 < sm8650-sepolicy_vndr.patch
rm -rf sm8650-sepolicy_vndr.patch
cd ../../../..
