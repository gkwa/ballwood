#!/bin/sh

cd /tmp/ || exit

DIST_DIR=$(mktemp -d)
TPL_DIST=/tmp/src/streambox-templates-app
LGN_DIST=/tmp/src/sbphplogin-reactapp

if [ ! -e /tmp/DEBIAN/control ]; then
    echo "ERR: no DEB-control archive file found"
    exit
fi

mkdir -p "${DIST_DIR}/DEBIAN"
cp /tmp/DEBIAN/control "${DIST_DIR}/DEBIAN"

for i in "${TPL_DIST}/dist/templates/"*; do
    CF="$(basename "$i")"
    echo "/var/local/WebData/templates/${CF}" >>"${DIST_DIR}/DEBIAN/conffiles"
done

mkdir -p "${DIST_DIR}/var/www/images/"
mkdir -p "${DIST_DIR}/var/www/assets/"
mkdir -p "${DIST_DIR}/var/www/sbuiapp/"
mkdir -p "${DIST_DIR}/var/www/sbuiauth/"
mkdir -p "${DIST_DIR}/var/local/WebData/templates/"

chown www-data "${DIST_DIR}/var/local/WebData/templates/"

cp "${TPL_DIST}/dist/images/"*    "${DIST_DIR}/var/www/images/"
cp "${TPL_DIST}/dist/assets/"*    "${DIST_DIR}/var/www/assets/"
cp "${TPL_DIST}/dist/index.html"  "${DIST_DIR}/var/www/sbuiapp/"
cp "${LGN_DIST}/"*                "${DIST_DIR}/var/www/sbuiauth/"
cp "${TPL_DIST}/dist/templates/"* "${DIST_DIR}/var/local/WebData/templates/"

dpkg -b "${DIST_DIR}" .
