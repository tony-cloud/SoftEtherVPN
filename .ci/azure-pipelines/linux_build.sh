#!/bin/bash

if [[ "${#SE_BUILD_NUMBER_TOKEN}" -eq 64 ]]; then
	VERSION=$(python3 "version.py")
	BUILD_NUMBER=$(curl "https://softether.network/get-build-number?commit=${BUILD_SOURCEVERSION}&version=${VERSION}&token=${SE_BUILD_NUMBER_TOKEN}")
else
	BUILD_NUMBER=5180
fi

cd ${BUILD_BINARIESDIRECTORY}
export USE_MUSL=1

cmake -G "Ninja" -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_NUMBER=${BUILD_NUMBER} ${BUILD_SOURCESDIRECTORY}
cmake --build .

cpack -C Release -G DEB 
