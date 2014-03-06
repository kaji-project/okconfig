#!/bin/bash

version="1.2.3"
release="1"

rm -rf build/
mkdir -p build/
git clone https://github.com/opinkerfi/okconfig.git build/okconfig-${version}
cd build/okconfig-${version}
git checkout okconfig-${version}-${release}

cp -r ../../debian .

python setup.py build
okconfig init
okconfig verify
rm -rf build/
cd ..

tar czf okconfig_${version}.orig.tar.gz okconfig-${version}
cd okconfig-${version}

dpkg-buildpackage -tc -us -uc

# copy patches
cp debian/patches/*.patch ../../
# copy deb files
cd ..
cp okconfig*.changes okconfig*.dsc okconfig*.tar.xz okconfig*.tar.gz ../
