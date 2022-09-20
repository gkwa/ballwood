#!/bin/sh

cd /tmp/ || exit

DIST_DIR=$(mktemp -d /tmp/dist.XXX)

LGN_DIST=/tmp/src/sbphplogin-reactapp
TPL_DIST=/tmp/src/streambox-templates-app

HTML_DIR="${DIST_DIR}/var/www/html"
WEBDATA_DIR="${DIST_DIR}/var/local/WebData"

mkdir -p "${WEBDATA_DIR}/templates/"
mkdir -p "${HTML_DIR}/sbuiapp/"
mkdir -p "${HTML_DIR}/assets/"
mkdir -p "${HTML_DIR}/sbuiauth/"
mkdir -p "${HTML_DIR}/images/"

cp "${LGN_DIST}/"*                 "${HTML_DIR}/sbuiauth/"
cp "${TPL_DIST}/dist/templates/"*  "${WEBDATA_DIR}/templates/"
cp "${TPL_DIST}/public/images/"*   "${HTML_DIR}/images/"
cp "${TPL_DIST}/dist/assets/"*     "${HTML_DIR}/assets/"
cp "${TPL_DIST}/dist/index.html"   "${HTML_DIR}/sbuiapp/"

cd "${DIST_DIR}" || exit
tar cfz ~/rpmbuild/SOURCES/streambox-react-webui.tgz ./*

if [ ! -e ~/rpmbuild/SPECS/reactwebui.spec ]; then
    echo "SPEC file not exists"
    exit 1
fi

rpmbuild -bb ~/rpmbuild/SPECS/reactwebui.spec
