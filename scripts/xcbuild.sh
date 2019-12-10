set -x

git clone https://github.com/facebook/xcbuild.git xcbuild-src
cd xcbuild-src
git checkout 57fe28235a72318b8266a1c4b9d4d0f10e2ff876
git submodule sync
git submodule update --init
cd ..
mkdir xcbuild-build
cd xcbuild-build
cmake -DCMAKE_INSTALL_PREFIX=/opt/xcbuild -DCMAKE_BUILD_TYPE=Release ../xcbuild-src
make -j$(nproc)
make -j$(nproc) install
cd ..
rm -rf xcbuild-build xcbuild-src
