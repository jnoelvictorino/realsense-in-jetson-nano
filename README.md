# RealSense SDK in Jetson Nano

## Tested
* Jetson Nano™ Developer Kit (4GB)
  * JetPack: 4.6.1-b110 (L4T 32.7.1)
  * Arch: aarch64 / arm64
  * Ubuntu: 18.04.5 LTS
* Python 3.6.9
* `librealsense` 2.53.1
* Intel® RealSense D435

## Via Docker
```bash
docker pull jvictorino/l4t-ml-realsense:r32.7.1-py3-latest
```

## Install from RealSense SDK repository

1. Update & install packages
```bash
apt-get update
apt install -y --no-install-recommends \
    software-properties-common \
    libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev
```

2. Register server's public key
```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
```

3. Add server to apt sources
```bash
add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
```

4. Install librealsense2
```bash
apt-get update && \
apt-get install -y --no-install-recommends \
  librealsense2-utils librealsense2-dev
```


## Build from source
```bash
git clone --branch v2.53.1 https://github.com/IntelRealSense/librealsense.git

mkdir librealsense/build
cd librealsense/build

cmake .. -DBUILD_EXAMPLES=true \
  -DCMAKE_BUILD_TYPE=release \
  -DFORCE_RSUSB_BACKEND=false \
  -DBUILD_WITH_CUDA=true \
  -DBUILD_PYTHON_BINDINGS:bool=true \
  -DPYTHON_EXECUTABLE=/usr/bin/python3

make -j$(($(nproc)-1)) && make install 
```

Then add the following line to your `~/.bashrc` or `/etc/profile` file:
```
export PYTHONPATH="${PYTHONPATH}:/usr/local/lib/python3.6/pyrealsense2"
```

# References
* [`librealsense`'s Installation Jetson](https://github.com/IntelRealSense/librealsense/blob/master/doc/installation_jetson.md)
* [`librealsense`'s Python Wrapper](https://github.com/IntelRealSense/librealsense/tree/master/wrappers/python#python-wrapper)
* [Pyrealsense2 on Jetson Nano with Python 3.6](https://github.com/Martin-Li-96/Pyrealsense2-on-Jetson-Nano-with-Python3-6)
* [Intel RealSense comment to the `librealsense` GitHub](https://support.intelrealsense.com/hc/en-us/community/posts/360038327173-how-to-use-realsense-on-nvidia-jetson-tx2-armx64-)