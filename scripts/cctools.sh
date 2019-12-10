set -x

git clone https://github.com/tpoechtrager/cctools-port.git
cd cctools-port
git checkout 22ebe727a5cdc21059d45313cf52b4882157f6f0
cd cctools
CFLAGS="-D_FORTIFY_SOURCE=0 -O3" ./configure --prefix=/opt/cctools --with-libtapi=/opt/cctools
make -j$(nproc)
make -j$(nproc) install
cd ../..
rm -rf cctools-port
