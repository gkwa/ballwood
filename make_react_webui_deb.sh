#!/bin/sh

set -e

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

mkdir -p "${DIST_DIR}/var/local/WebData/templates/"

mkdir -p "${DIST_DIR}/var/www/images/"
cp "${TPL_DIST}/dist/images/"* "${DIST_DIR}/var/www/images/"

mkdir -p "${DIST_DIR}/var/www/assets/"
cp "${TPL_DIST}/dist/assets/"* "${DIST_DIR}/var/www/assets/"

mkdir -p "${DIST_DIR}/var/www/sbuiapp/"
cp "${TPL_DIST}/dist/index.html" "${DIST_DIR}/var/www/sbuiapp/"

cp "${TPL_DIST}/dist/templates/"* "${DIST_DIR}/var/local/WebData/templates/"

mkdir -p "${DIST_DIR}/var/local/WebData/logo/"

cp "${LGN_DIST}/logo/logo.jpg" "${DIST_DIR}/var/local/WebData/logo/"
chown -R www-data "${DIST_DIR}/var/local/WebData/logo/"
chmod 777 "${DIST_DIR}/var/local/WebData/logo/"

mkdir -p "${DIST_DIR}/var/www/sbuiauth/"
cp "${LGN_DIST}/receiveFile.php"    "${DIST_DIR}/var/www/sbuiauth/"
cp "${LGN_DIST}/uploadFile.php"     "${DIST_DIR}/var/www/sbuiauth/"
cp "${LGN_DIST}/styles.css"         "${DIST_DIR}/var/www/sbuiauth/"
cp "${LGN_DIST}/index.php"          "${DIST_DIR}/var/www/sbuiauth/"
cp "${LGN_DIST}/auth.php"           "${DIST_DIR}/var/www/sbuiauth/"
cp "${LGN_DIST}/streambox-logo.svg" "${DIST_DIR}/var/www/sbuiauth/"

chown www-data "${DIST_DIR}/var/local/WebData/templates/"
find "${DIST_DIR}/var/local/WebData/templates" -type d -print0 | xargs -0 -n1 chmod 777
find "${DIST_DIR}/var/local/WebData/" -type f -print0 | xargs -0 -n1 chmod 666
find "${DIST_DIR}/var/local/WebData/" -type f -print0 | xargs -0 -n1 chown www-data
chmod 777 "${DIST_DIR}/var/local/WebData/templates"

_pwd="$(pwd)"
cd "${DIST_DIR}/var/www/sbuiauth/"
ln -s ../../local/WebData/logo/ logo
cd "$_pwd"

dpkg --build "${DIST_DIR}" .
