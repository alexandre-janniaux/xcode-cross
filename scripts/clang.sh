#!/usr/bin/env sh
set -x

curl -LO http://releases.llvm.org/5.0.0/clang+llvm-5.0.0-linux-x86_64-ubuntu16.04.tar.xz
tar -Jxf clang+llvm-5.0.0-linux-x86_64-ubuntu16.04.tar.xz
rm clang+llvm-5.0.0-linux-x86_64-ubuntu16.04.tar.xz
mv clang+llvm-5.0.0-linux-x86_64-ubuntu16.04 clang
cd clang
mkdir bin-new
mv bin/clang-5.0 bin/clang bin/clang++ bin/llvm-dsymutil bin-new
rm -rf bin
mv bin-new bin
rm -rf lib/*.a lib/*.so lib/*.so.* lib/clang/5.0.0/lib/linux
