#!/bin/bash

. version

get_url() {
  local key="7f8faaaa468174dc1c9cd62e5f218a5b"
  local md5=$(echo -n $key$1$2 | md5sum | cut -d" " -f1)
  echo $md5
}

WPS_FILE="wps-office-${WPS_VERSION}.${WPS_RELEASE}-1.x86_64.rpm"
WPS_PATH="/wps/download/ep/Linux2019/${WPS_RELEASE}/${WPS_FILE}"
TIMESTAMP=$(date +%s)
WPS_URL="https://wps-linux-personal.wpscdn.cn${WPS_PATH}?t=${TIMESTAMP}&k=$(get_url ${WPS_PATH} ${TIMESTAMP})"
echo $WPS_URL

APPDIR="WPS_Office-x86_64.AppDir"
mkdir -p ${APPDIR}
wget -c ${WPS_URL} -O ${APPDIR}/${WPS_FILE}
cp -r AppRun ${APPDIR}
cp -r com.wps.Office.desktop ${APPDIR}
cp -r wps-launcher ${APPDIR}

pushd ${APPDIR}
chmod +x AppRun
unrpm ${WPS_FILE}
rm -rf ${WPS_FILE}
cp -r usr/share/icons/hicolor/256x256/mimetypes/wps-office2019-kprometheus.png .
cp -r usr/share/icons/hicolor/256x256/mimetypes/wps-office2019-kprometheus.png ./.DirIcon
popd

APPIMAGETOOL=$(wget -q https://api.github.com/repos/probonopd/go-appimage/releases -O - | sed 's/[()",{} ]/\n/g' | grep -o 'https.*continuous.*tool.*86_64.*mage$' | head -1)
wget "$APPIMAGETOOL" -O ./appimagetool-x86_64.AppImage
chmod +x appimagetool-x86_64.AppImage

ARCH=x86_64 VERSION="${WPS_VERSION}" ./appimagetool-x86_64.AppImage -s ${APPDIR}
