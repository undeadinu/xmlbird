#!/bin/bash

rep="$(pwd)"

mkdir -p build
cd build
mkdir -p export
cd export 

version=$(cat ../../scripts/version.py | grep "XMLBIRD_VERSION = '" | sed -e "s:XMLBIRD_VERSION = '::" | sed "s:'.*::g")

rm -rf libxmlbird-$version

git clone --depth 1 --no-hardlinks --local $rep

mv xmlbird libxmlbird-$version

rm -rf libxmlbird-$version/.git
rm -rf libxmlbird-$version/.gitignore
rm -rf libxmlbird-$version/.travis.yml

tar -cf libxmlbird-$version.tar libxmlbird-$version

xz -z libxmlbird-$version.tar

rm -rf ../libxmlbird-$version.tar.xz

mv libxmlbird-$version.tar.xz ../

# build it to make sure that everything was checked in
cd libxmlbird-$version && \
./configure && \
doit && \
gpg --output ../../libxmlbird-$version.tar.xz.sig --detach-sig ../../libxmlbird-$version.tar.xz && \
cd .. && \
rm -rf ../export/libxmlbird-$version
