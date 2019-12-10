set -x

git clone https://github.com/tpoechtrager/apple-libtapi.git
cd apple-libtapi
git checkout 84c0c83c435e3d916673b1aa48905047e8d422d0
cd ..
mkdir apple-libtapi-build
cd apple-libtapi-build
cmake -DCMAKE_INSTALL_PREFIX=/opt/cctools -DCMAKE_BUILD_TYPE=Release -DLLVM_INCLUDE_TESTS=OFF ../apple-libtapi/src/apple-llvm/src
make -j$(nproc) libtapi
make -j$(nproc) install-libtapi
mkdir -p /opt/cctools/include
cp -a ../apple-libtapi/src/apple-llvm/src/projects/libtapi/include/tapi /opt/cctools/include
cp projects/libtapi/include/tapi/Version.inc /opt/cctools/include/tapi
cd ..
rm -rf apple-libtapi apple-libtapi-build
