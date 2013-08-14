#!/bin/bash


# ffmpeg compile linux mint
#==========================


# Get the Dependencies for ffmpeg
#================================

sudo apt-get update

sudo apt-get -y install autoconf automake build-essential git libass-dev libgpac-dev \
libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev \
libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev
	

# create a directory for the ffmpeg sources
# =========================================

mkdir ~/ffmpeg_sources

cd ~/ffmpeg_sources


# install Yasm an assembler used by x264 and FFmpeg
# =================================================

wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
tar xzvf yasm-1.2.0.tar.gz
cd yasm-1.2.0
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
make
make install
make distclean
. ~/.profile


# install x264 the H.264 video encoder
#=====================================

cd ~/ffmpeg_sources
git clone --depth 1 git://git.videolan.org/x264.git
cd x264
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
make
make install
make distclean

# install fdk-aac, AAC audio encoder
# ==================================

cd ~/ffmpeg_sources
git clone --depth 1 git://github.com/mstorsjo/fdk-aac.git
cd fdk-aac
autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
make distclean


# install libmp3lame, MP3 audio encoder
# =====================================

sudo apt-get install libmp3lame-dev


# install libopus, Opus audio decoder and encoder
# ===============================================

cd ~/ffmpeg_sources
wget http://downloads.xiph.org/releases/opus/opus-1.0.3.tar.gz
tar xzvf opus-1.0.3.tar.gz
cd opus-1.0.3
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
make distclean


# install libvpx, VP8/VP9 video encoder and decoder.
# ==================================================

cd ~/ffmpeg_sources
git clone --depth 1 http://git.chromium.org/webm/libvpx.git
cd libvpx
./configure --prefix="$HOME/ffmpeg_build" --disable-examples
make
make install
make clean


# install ffmpeg
# ==============

cd ~/ffmpeg_sources
git clone --depth 1 git://source.ffmpeg.org/ffmpeg
cd ffmpeg
PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig"
export PKG_CONFIG_PATH
./configure --prefix="$HOME/ffmpeg_build" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --bindir="$HOME/bin" --extra-libs="-ldl" --enable-gpl --enable-libass --enable-libfdk-aac \
  --enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx \
  --enable-libx264 --enable-nonfree --enable-x11grab
make
make install
make distclean
hash -r

# Important now reinstall x264 and ffmpeg so x264 picks up the ffmpeg headers
# ===========================================================================

# just follow the steps to install x264 and ffmpeg again
# ======================================================



# check the ffmpeg build
# ======================

$ ffmpeg 2>&1 | head -n1
ffmpeg version git-2013-05-18-5918b7a Copyright (c) 2000-2013 the FFmpeg developers


# Updating FFmpeg
# ===============

# Development of FFmpeg is active and an occasional update can give you new features and bug fixes. 
# First, remove (or move) the old files and then update the dependencies:

rm -rf ~/ffmpeg_build ~/bin/{ffmpeg,ffprobe,ffserver,vsyasm,x264,yasm,ytasm}
sudo apt-get update
sudo apt-get -y install autoconf automake build-essential git libass-dev libgpac-dev \
  libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev \
  libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev


# updating x264
# =============

cd ~/ffmpeg_sources/x264
make distclean
git pull

# now run ./configure, make, make install again, see below
# ========================================================

./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
make
make install
make distclean


# updating fdk-aac
# ================

cd ~/ffmpeg_sources/fdk-aac
make distclean
git pull


# Now run ./configure, make, and make install again, see below
#=============================================================

autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
make distclean


# updating libvpx
# ===============

cd ~/ffmpeg_sources/libvpx
make clean
git pull


# Now run ./configure, make, and make install again, see below
# ============================================================

./configure --prefix="$HOME/ffmpeg_build" --disable-examples
make
make install
make clean


# updating ffmpeg
# ===============

cd ~/ffmpeg_sources/ffmpeg
make distclean
git pull


# Now run ./configure, make, and make install again, see below
# ============================================================

PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig"
export PKG_CONFIG_PATH
./configure --prefix="$HOME/ffmpeg_build" \
--extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
--bindir="$HOME/bin" --extra-libs="-ldl" --enable-gpl --enable-libass --enable-libfdk-aac \
--enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx \
--enable-libx264 --enable-nonfree --enable-x11grab
make
make install
make distclean
hash -r


# Reverting Changes
#==================

# To remove ffmpeg, x264, and dependencies installed
#===================================================

rm -rf ~/ffmpeg_build ~/ffmpeg_sources ~/bin/{ffmpeg,ffprobe,ffserver,vsyasm,x264,yasm,ytasm}
sudo apt-get autoremove autoconf automake build-essential git libass-dev libgpac-dev \
libmp3lame-dev libopus-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev \
libvorbis-dev libvpx-dev libx11-dev libxext-dev libxfixes-dev texi2html zlib1g-dev
hash -r
